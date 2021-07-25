resource "random_integer" "suffix" {
  max = 100
  min = 1000000
}

locals {

  region               = var.gcp_region
  org_id               = var.org_id
  folder_id            = var.folder_id
  billing_account      = var.billing_account
  host_project_name    = "network-host"
  service_project_name = "application-project"
  host_project_id      = "${local.host_project_name}-${random_integer.suffix.result}"
  service_project_id   = "${local.service_project_name}-${random_integer.suffix.result}"

  secondary_ip_ranges = {}

  common_labels = {
    owner       = var.owner
    team        = var.team
    environment = var.environment
    component   = var.component
  }

}