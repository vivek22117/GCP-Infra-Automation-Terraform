resource "google_project" "host-staging" {
  name                = local.host_project_name
  project_id          = local.host_project_id
  billing_account     = local.billing_account
  org_id              = local.org_id
  folder_id = local.folder_id
  auto_create_network = false

  labels = merge(local.common_tags, map("Name", "${var.environment}-${local.host_project_name}"))
}

resource "google_project" "k8s-staging" {
  name                = local.service_project_name
  project_id          = local.service_project_id
  billing_account     = local.billing_account
  org_id              = local.org_id
  folder_id = local.folder_id
  auto_create_network = false

  labels = merge(local.common_tags, map("Name", "${var.environment}-${local.service_project_name}"))
}

resource "google_project_service" "host" {
  project = google_project.host-staging.number
  service = local.projects_api
}

resource "google_project_service" "service" {
  project = google_project.k8s-staging.number
  service = local.projects_api
}