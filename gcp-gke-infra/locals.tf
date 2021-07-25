resource "random_integer" "suffix" {
  max = 100
  min = 1000000
}

locals {

  region               = var.gcp_region
  org_id               = var.org_id
  billing_account      = var.billing_account
  host_project_name    = "host-project"
  service_project_name = "k8s-project"
  host_project_id      = "${local.host_project_name}-${random_integer.suffix.result}"
  service_project_id   = "${local.service_project_name}-${random_integer.suffix.result}"

  projects_api = "container.googleapis.com"
  secondary_ip_ranges = {
    "pod-ip-range"     = "10.0.0.0/14",
    "service-ip-range" = "10.4.0.0/19"
  }

  common_labels = {
    owner       = var.owner
    team        = var.team
    environment = var.environment
    component   = var.component
  }

}