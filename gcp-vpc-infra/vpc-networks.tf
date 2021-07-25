resource "google_compute_subnetwork" "private_subnet" {
  for_each = var.private_subnet_with_cidr

  name          =  format("%s","${var.component}-${var.environment}-${each.key}-pub-net")
  project = google_compute_shared_vpc_host_project.network-host.project
  network       = google_compute_network.vpc.self_link
  ip_cidr_range = each.value
  region        = each.key
  private_ip_google_access = true


  dynamic "secondary_ip_range" {
    for_each = length(local.secondary_ip_ranges) > 0 ? local.secondary_ip_ranges : []

    content {
      range_name    = secondary_ip_range.key
      ip_cidr_range = secondary_ip_range.value
    }
  }
}

resource "google_compute_subnetwork" "public_subnet" {
  for_each = var.public_subnet_with_cidr

  name          =  format("%s","${var.component}-${var.environment}-${each.key}-pub-net")
  project = google_compute_shared_vpc_host_project.network-host.project
  network       = google_compute_network.vpc.self_link
  ip_cidr_range = each.value
  region        = each.key
  private_ip_google_access = true


  dynamic "secondary_ip_range" {
    for_each = length(local.secondary_ip_ranges) > 0 ? local.secondary_ip_ranges : []

    content {
      range_name    = secondary_ip_range.key
      ip_cidr_range = secondary_ip_range.value
    }
  }
}

resource "google_compute_subnetwork_iam_binding" "public_network_binding" {
  count = length(google_compute_subnetwork.public_subnet)

  project    = google_compute_shared_vpc_host_project.network-host.project
  region     = google_compute_subnetwork.public_subnet[count.index].region
  subnetwork = google_compute_subnetwork.public_subnet[count.index].name

  role = "roles/compute.networkUser"
  members = [
    "serviceAccount:${data.google_service_account.admin_srv_account.email}",
    "serviceAccount:${google_project.application-host.number}@cloudservices.gserviceaccount.com"
  ]
}

resource "google_compute_subnetwork_iam_binding" "private_network_binding" {
  count = length(google_compute_subnetwork.private_subnet)

  project    = google_compute_shared_vpc_host_project.network-host.project
  region     = google_compute_subnetwork.private_subnet[count.index].region
  subnetwork = google_compute_subnetwork.private_subnet[count.index].name

  role = "roles/compute.networkUser"
  members = [
    "serviceAccount:${data.google_service_account.admin_srv_account.email}",
    "serviceAccount:${google_project.application-host.number}@cloudservices.gserviceaccount.com"
  ]
}