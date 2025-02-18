variable "location" {
  description = "Location to which resources will be deployed"
  type        = string
  validation {
    condition     = contains(["westeurope"], var.location)
    error_message = "Variable location needs to be within supported deployment regions."
  }
}

variable "env_hdl" {
  description = "Environment shorthandle (e.g. prd = production)"
  type        = string
  validation {
    condition     = contains(["dev", "prd", "tst"], var.env_hdl)
    error_message = "Variable env_hdl needs to be dev (Development), prd (Production) or tst (Test)."
  }
}

variable "loc_hdl" {
  description = "Location shorthandle (e.g. we1 = west europe 1)"
  type        = string
  validation {
    condition     = contains(["we1"], var.loc_hdl)
    error_message = "Location handle needs to be within supported deployment regions."
  }
}

variable "subscription_id" {
  description = "Azure Subscription id"
  type        = string
  validation {
    condition     = can(regex("^[0-9a-fA-F-]{36}$", var.subscription_id))
    error_message = "The subscription ID must be a valid UUID."
  }
}

variable "team" {
  description = "ADAPT team"
  type        = string
  validation {
    condition     = contains(["ctoda","operations","pricing","uw"], var.team)
    error_message = "Team needs to be within supported teams."
  }
}

variable "adapt_user_group_id" {
  description = "ADAPT user group id"
  type        = string
}

variable "network_rg_name" {
  description = "Name of the networking RG in this deployment"
  type        = string
}

variable "network_vnet_name" {
  description = "Name of the vnet used for this deployment"
  type        = string
}

variable "network_subnet_name" {
  description = "Name of the subnet to provision the resources to"
  type        = string
}

variable "source_image_id" {
  description = "Source image id reference"
  type        = string
}

variable "virtual_machines" {
  description = "Mapping of VMs"
}

variable "customer_kv_sku" {
  type        = string
  description = "SKU for the keyvault"
  default     = "standard"
}

# Qualys variables
variable "qualys_activation_id" {
  description = "Qualys Activation ID"
  type        = string
}

variable "qualys_customer_id" {
  description = "Qualys Customer ID"
  type        = string
}

variable "tags" {}
