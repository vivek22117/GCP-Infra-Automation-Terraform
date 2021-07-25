data "google_service_account" "admin_srv_account" {
  account_id = var.srv_account_name
}

data "google_compute_image" "centos_image" {
  family  = "centos-8"
  project = "centos-cloud"
}

data "google_compute_image" "debian_image" {
  family  = "debian-10"
  project = "debian-cloud"
}

data "google_compute_image" "rhel_image" {
  family  = "rhel-8"
  project = "rhel-cloud"
}

data "google_compute_image" "container_optimized_image" {
  family  = "cos-89-lts"
  project = "cos-cloud"
}

data "google_compute_image" "ubuntu_image" {
  family  = "ubuntu-2004-lts"
  project = "ubuntu-os-cloud"
}


data "google_compute_image" "ubuntu_pro_image" {
  family  = "ubuntu-pro-2004-lts"
  project = "ubuntu-os-pro-cloud"
}


