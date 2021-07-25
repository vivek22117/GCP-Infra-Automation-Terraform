resource "google_compute_shared_vpc_host_project" "network-host" {
  project = google_project.application-host.number
}

resource "google_compute_shared_vpc_service_project" "application-service" {
  depends_on = [google_compute_shared_vpc_host_project.network-host]

  host_project    = local.host_project_id
  service_project = local.service_project_id

}

resource "google_compute_network" "vpc" {
  name    = format("%s", "${var.component}-${var.environment}-vpc")
  project = google_compute_shared_vpc_host_project.network-host.project

  auto_create_subnetworks = "false"
  routing_mode            = "GLOBAL"
}


resource "google_compute_firewall" "allow-internal" {
  name = "${var.component}-fw-allow-internal"

  network = google_compute_network.vpc.name

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

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }
  target_tags = ["http"]
}


resource "google_compute_firewall" "allow-bastion" {
  name    = "${var.component}-fw-allow-bastion"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  target_tags = ["ssh"]
}

resource "google_compute_firewall" "allow-db" {
  name    = "${var.component}-fw-allow-to-db"
  network = google_compute_network.vpc.name


  allow {
    protocol = "tcp"
    ports    = ["5432"]
  }
  target_tags = ["database"]
}