resource "google_project" "network-host" {
  name                = local.host_project_name
  project_id          = local.host_project_id
  billing_account     = local.billing_account
  folder_id           = local.folder_id
  auto_create_network = false

  labels = local.common_labels
}

resource "google_project" "application-host" {
  name                = local.service_project_name
  project_id          = local.service_project_id
  billing_account     = local.billing_account
  folder_id           = local.folder_id
  auto_create_network = false

  labels = local.common_labels
}

//resource "google_project_service" "host" {
//  project = google_project.host-staging.number
//  service = local.projects_api
//}
//
//resource "google_project_service" "service" {
//  project = google_project.k8s-staging.number
//  service = local.projects_api
//}