output "rg_customer" {
  value = azurerm_resource_group.customer_rg
}

output "kv_customer" {
  value = azurerm_key_vault.customer_kv
}

output "customer_vm" {
  value     = module.customer_vm
  sensitive = true
}

