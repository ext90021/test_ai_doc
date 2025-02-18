locals {
  combined_name = "azpa-${var.env_hdl}-analytics-${var.team}"
  combined_tags = merge({
    team = var.team
  }, try(var.tags, {}))

  cloud_init = templatefile("${path.module}/templates/cloud-init.yaml", {
    activation_id = var.qualys_activation_id
    customer_id   = var.qualys_customer_id
    })
}