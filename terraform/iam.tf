
#--------------------------------- Dev Team Roles -----------------------------------
resource "azurerm_role_assignment" "adapt_keyvault_user" {
  scope                = azurerm_key_vault.customer_kv.id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = var.adapt_user_group_id
}

resource "azurerm_role_assignment" "adapt_vm_start_stop" {
  for_each = module.customer_vm

  scope                = each.value.vm.id
  role_definition_name = "Virtual Machine start stop"
  principal_id         = var.adapt_user_group_id
}
