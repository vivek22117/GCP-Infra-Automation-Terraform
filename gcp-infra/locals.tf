locals {

  region = "us-west2"
  org_id = ""
  billing_account = ""
  host_project_name = "host-project"
  service_project_name = "k8s-project"
  host_project_id = "${local.host_project_name}-${random_integer.suffix.result}"
  service_project_id = "${local.service_project_name}-${random_integer.suffix.result}"

  project_api = "container.googleapis.com"
  secondary_ip_ranges = {
    "pod-ip-range" = "10.0.0.0/14",
    "service-ip-range" = "10.4.0.0/19"
  }

}