# cto-da3-customer-vm

## backend.config

| Parameter            | Description                                                                                  |
| -------------------- |----------------------------------------------------------------------------------------------|
| resource_group_name  | The Name of the Resource Group in which the Storage Account exists                           |
| storage_account_name | Name of the storage account                                                                  |
| container_name       | Name of the Storage Container within the Storage Account                                     |
| key                  | Name of the Blob used to retrieve/store Terraform's State file inside the Storage Container  |

## globals.tfvars

| Parameter           | Description |
|---------------------|-------------|
| location            |             |
| env_hdl             |             |
| loc_hdl             |             |
| team                |             |
| network_rg_name     |             |
| network_vnet_name   |             |
| network_subnet_name |             |
| adapt_user_group_id |             |
| source_image_id     |             |
| tags                |             |

```
location        = "westeurope"
env_hdl         = "prd"
loc_hdl         = "we1"
team            = "ctoda"
subscription_id = "deed78d6-ab50-4ab1-ba51-f62eb979b9e0"
tags            = {}

network_rg_name     = "rg-p-we1-azp-adpfcpvn-networking"
network_vnet_name   = "vnet-p-we1-azp-adpfcpvn"
network_subnet_name = "sub-p-we1-transitional-44.142.214.0-23"

adapt_user_group_id = "39bb467b-d027-46f5-8ada-44b57b061ee8" #AZP_Data_Platform_Analytics_CTO_DA3

source_image_id     = "/subscriptions/deed78d6-ab50-4ab1-ba51-f62eb979b9e0/resourceGroups/rg-fcpazp-prod-vm/providers/Microsoft.Compute/galleries/ProdVMGallery/images/vmGenericDa/versions/0.0.2"
```

## customer.tfvars
```
virtual_machines = {
  example-1 = {
    name_suffix     = "example-1"
    vm_size         = "Standard_D2ds_v4"
    admin_username  = "vmadmin"
    os_disk_size_gb = 150
    data_disk_size  = 1

    backup = {
      enabled = true
      inline_policy = {
        backup_frequency = "Daily"
        backup_time      = "22:00"
        backup_timezone  = "UTC"

        retention_daily_count = 20

        retention_weekly_count = 42
        retention_weekly_weekdays = ["Monday", "Wednesday", "Friday", "Saturday"]

        retention_monthly_count = 7
        retention_monthly_weekdays = ["Sunday", "Wednesday"]
        retention_monthly_weeks = ["First", "Third"]
        retention_yearly_count  = 77
        retention_yearly_weekdays = ["Sunday"]
        retention_yearly_weeks = ["Last"]
        retention_yearly_months = ["January"]
      }
    }
  }
}
```
