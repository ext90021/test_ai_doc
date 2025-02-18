
# create customer Resource Group
resource "azurerm_resource_group" "customer_rg" {
  name     = "rg-${local.combined_name}"
  location = var.location
  tags     = local.combined_tags
}

# create customer Key Vault
resource "azurerm_key_vault" "customer_kv" {
  name                = "kv-azpa-${var.env_hdl}-${var.team}"
  location            = azurerm_resource_group.customer_rg.location
  tags                = local.combined_tags
  tenant_id           = data.azurerm_subscription.current.tenant_id
  resource_group_name = azurerm_resource_group.customer_rg.name

  purge_protection_enabled   = true
  enable_rbac_authorization  = true
  soft_delete_retention_days = 7
  sku_name                   = var.customer_kv_sku
}

module "customer_vm" {
  source   = "git::https://github.developer.allianz.io/azpa-data-platform/tfmodule-azurerm-resource-vm.git?ref=1.0.0"

  for_each = var.virtual_machines

  resource_group_name     = azurerm_resource_group.customer_rg.name
  resource_group_location = azurerm_resource_group.customer_rg.location

  name              = "${local.combined_name}-${each.key}"
  subnet_id         = data.azurerm_subnet.subnet.id
  vm_size           = each.value.vm_size
  admin_username    = each.value.admin_username
  os_disk_size_gb   = each.value.os_disk_size_gb
  data_disk_size    = each.value.data_disk_size

  shutdown_time     = each.value.shutdown_time
  notification_mail = each.value.notification_mail

  source_image_id   = var.source_image_id

  custom_data = base64encode(local.cloud_init)

  backup_vault = {
    backup_vault_name   = azurerm_recovery_services_vault.customer_bv.name
    resource_group_name = azurerm_recovery_services_vault.customer_bv.resource_group_name
  }

  backup = merge(
    try(each.value.backup,
      {
        enabled       = false
        inline_policy = null
    }),
    {
      custom_provided_policy_id = ""
    }
  )

  tags = local.combined_tags
}

# create a backup vault
resource "azurerm_recovery_services_vault" "customer_bv" {
  resource_group_name = azurerm_resource_group.customer_rg.name
  location            = azurerm_resource_group.customer_rg.location

  name                = "bv-${local.combined_name}"
  sku                 = "Standard"
  soft_delete_enabled = false

  identity {
    type = "SystemAssigned"
  }
}

module "customer_vm_secrets" {
  source   = "git::https://github.developer.allianz.io/azpa-data-platform/tfmodule-azurerm-resource-kv-secret.git?ref=1.0.0"

  for_each = module.customer_vm

  config = {
    "ssh-key" = {
      name         = "${each.value.vm_name}-ssh-key"
      value        = each.value.private_key_pem
      key_vault_id = azurerm_key_vault.customer_kv.id
    },
    "vm-user" = {
      name         = "${each.value.vm_name}-vm-user"
      value        = each.value.vm_admin_username
      key_vault_id = azurerm_key_vault.customer_kv.id
    },
    "vm-ip" = {
      name         = "${each.value.vm_name}-vm-ip"
      value        = each.value.vm_network_interface.ip_configuration.0.private_ip_address
      key_vault_id = azurerm_key_vault.customer_kv.id
    }
  }
  tags = local.combined_tags
}
