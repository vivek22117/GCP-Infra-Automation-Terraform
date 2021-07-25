resource "google_compute_instance" "default" {
  depends_on = [google_compute_subnetwork.public_subnet]
  for_each   = var.public_subnet_with_cidr

  name         = format("%s", "${var.component}-${var.environment}-${each.key}-instance-1")
  machine_type = "n1-standard-1"
  zone         = format("%s", "${each.key}-b")
  tags         = ["ssh", "http"]

  boot_disk {
    auto_delete = true
    initialize_params {
      image = data.google_compute_image.centos_image.self_link
    }
  }

  labels = {
    webserver = "true"
  }

  metadata = {
    startup-script = <<SCRIPT
        apt-get -y update
        apt-get -y install nginx
        export HOSTNAME=$(hostname | tr -d '\n')
        export PRIVATE_IP=$(curl -sf -H 'Metadata-Flavor:Google' http://metadata/computeMetadata/v1/instance/network-interfaces/0/ip | tr -d '\n')
        echo "Welcome to $HOSTNAME - $PRIVATE_IP" > /usr/share/nginx/www/index.html
        service nginx start
        SCRIPT
  }

  network_interface {
    subnetwork = google_compute_subnetwork.public_subnet[each.key].name
    access_config {
      // Ephemeral IP
    }
  }
}