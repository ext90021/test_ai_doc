data "azurerm_subscription" "current" {
}

# Networking data

data "azurerm_resource_group" "network_rg" {
  name = var.network_rg_name
}

data "azurerm_subnet" "subnet" {
  name                 = var.network_subnet_name
  virtual_network_name = var.network_vnet_name
  resource_group_name  = var.network_rg_name
}
