#####============================== Create a GCS Bucket ================================#####
resource "google_storage_bucket" "tf_state_bucket" {
  name          = "${var.bucket_name_prefix}-${var.gcp_region}-${var.environment}"
  project       = var.gcp_project
  location      = var.gcp_region
  force_destroy = true
  storage_class = var.storage_class

  versioning {
    enabled = true
  }
  labels = merge(local.common_tags, map("Name", "${var.bucket_name_prefix}-${var.gcp_region}-${var.environment}"))
}