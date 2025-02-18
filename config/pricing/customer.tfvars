team    = "pricing"
env_hdl = "prd"

subscription_id     = "deed78d6-ab50-4ab1-ba51-f62eb979b9e0"

network_rg_name     = "rg-p-we1-azp-adpfcpvn-networking"
network_vnet_name   = "vnet-p-we1-azp-adpfcpvn"
network_subnet_name = "sub-p-we1-transitional-44.142.214.0-23"

adapt_user_group_id = "66a00abe-7df9-4b48-8222-c168dc2c5e36" #AZP_Data_Platform_Analytics_Pricing_Portfolio
source_image_id     = "/subscriptions/deed78d6-ab50-4ab1-ba51-f62eb979b9e0/resourceGroups/rg-fcpazp-prod-vm/providers/Microsoft.Compute/galleries/ProdVMGallery/images/vmPricingDa/versions/0.0.2"

virtual_machines = {
  dong-1 = {
    name_suffix     = "dong-1"
    notification_mail = "rafael.palomino-martinez@allianz.de"
    shutdown_time   = "1800"
    vm_size         = "Standard_D2ds_v4"
    admin_username  = "vmadmin"
    os_disk_size_gb = 150
    data_disk_size  = 1

    backup = {
      enabled = false
      inline_policy = {
        policy_type      = "V2"
        backup_frequency = "Daily"
        backup_time      = "22:00"
        backup_timezone  = "UTC"

        retention_daily_count = 20

        retention_weekly_count    = 42
        retention_weekly_weekdays = ["Monday", "Wednesday", "Friday", "Saturday"]

        retention_monthly_count    = 7
        retention_monthly_weekdays = ["Sunday", "Wednesday"]
        retention_monthly_weeks    = ["First", "Third"]
        retention_yearly_count     = 77
        retention_yearly_weekdays  = ["Sunday"]
        retention_yearly_weeks     = ["Last"]
        retention_yearly_months    = ["January"]
      }
    }
  },
  fra-1 = {
    name_suffix     = "fra-1"
    notification_mail = "rafael.palomino-martinez@allianz.de"
    shutdown_time   = "1800"
    vm_size         = "Standard_D2s_v3"
    admin_username  = "vmadmin"
    os_disk_size_gb = 150
    data_disk_size  = 1
    ipaddress       = "44.142.214.13"

    backup = {
      enabled = false
      inline_policy = {
        policy_type      = "V2"
        backup_frequency = "Daily"
        backup_time      = "22:00"
        backup_timezone  = "UTC"

        retention_daily_count = 20

        retention_weekly_count    = 42
        retention_weekly_weekdays = ["Monday", "Wednesday", "Friday", "Saturday"]

        retention_monthly_count    = 7
        retention_monthly_weekdays = ["Sunday", "Wednesday"]
        retention_monthly_weeks    = ["First", "Third"]

        retention_yearly_count    = 77
        retention_yearly_weekdays = ["Sunday"]
        retention_yearly_weeks    = ["Last"]
        retention_yearly_months   = ["January"]
      }
    }
  } #END prod
}   #END VMS