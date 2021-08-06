resource "google_compute_shared_vpc_host_project" "network-host" {
  depends_on = [google_compute_network.vpc]

  project = google_project.network-host.number
}

resource "google_compute_shared_vpc_service_project" "application-service" {
  depends_on = [google_compute_shared_vpc_host_project.network-host]

  host_project    = google_compute_shared_vpc_host_project.network-host.project
  service_project = google_project.application-host.project_id

}

resource "google_compute_network" "vpc" {
  name    = format("%s", "${var.component}-${var.environment}-vpc")
  project = google_project.network-host.project_id
  description = "Host network"

  auto_create_subnetworks = "false"
  routing_mode            = "GLOBAL"
}


resource "google_compute_firewall" "allow-internal" {
  name = "${var.component}-fw-allow-internal"

  network = google_compute_network.vpc.name
  project = google_project.network-host.project_id

  allow {
    protocol = "icmp"
  }
  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }
  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }

  source_ranges = flatten([values(var.public_subnet_with_cidr), values(var.private_subnet_with_cidr)])
}

resource "google_compute_firewall" "allow-http" {
  name    = "${var.component}-fw-allow-http"
  network = google_compute_network.vpc.name
  project = google_project.network-host.project_id

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }
  target_tags = ["http"]
}


resource "google_compute_firewall" "allow-bastion" {
  name    = "${var.component}-fw-allow-bastion"
  network = google_compute_network.vpc.name
  project = google_project.network-host.project_id

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  target_tags = ["ssh"]
}

resource "google_compute_firewall" "allow-db" {
  name    = "${var.component}-fw-allow-to-db"
  network = google_compute_network.vpc.name
  project = google_project.network-host.project_id


  allow {
    protocol = "tcp"
    ports    = ["5432"]
  }
  target_tags = ["database"]
}
