resource "google_compute_router" "router" {
  name    = "router"
  region  = local.region
  project = local.host_project_id
  network = google_compute_network.main.self_link
}

resource "google_compute_router_nat" "mist_nat" {
  depends_on = [google_compute_subnetwork.private]

  name                               = "nat"
  project                            = local.host_project_id
  router                             = google_compute_router.router.name
  region                             = local.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

}