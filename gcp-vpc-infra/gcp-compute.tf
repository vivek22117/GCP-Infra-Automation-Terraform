resource "google_compute_instance" "default" {
  count = length(var.public_subnet_with_cidr)

  name         = format("%s","${var.component}-${var.environment}-${google_compute_subnetwork.public_subnet[count.index].region}-${count.index}")
  machine_type  = "n1-standard-1"
  zone          =   format("%s","${google_compute_subnetwork.public_subnet[count.index].region}-b")
  tags          =   ["ssh","http"]

  boot_disk {
    auto_delete = true
    initialize_params {
      image     =  data.google_compute_image.centos_image.self_link
    }
  }

  labels = {
    webserver =  "true"
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
    subnetwork = google_compute_subnetwork.public_subnet[count.index].name
    access_config {
      // Ephemeral IP
    }
  }
}