locals {
  gcs_labels     = {
    "environment" = var.environment
    "team"        = var.team
    "component" = var.component
    "owner" = var.owner
  }
}

#####============================== Create a GCS Bucket ================================#####
resource "google_storage_bucket" "tf_state_bucket" {
  name          = "${var.bucket_name_prefix}-${var.gcp_region}-${var.environment}"
  project       = var.gcp_project
  location      = var.gcp_region
  force_destroy = var.force_destroy
  storage_class = var.storage_class

  dynamic "retention_policy" {
    for_each = var.retention_policy == null ? [] : [var.retention_policy]
    content {
      is_locked        = var.retention_policy.is_locked
      retention_period = var.retention_policy.retention_period
    }
  }

  dynamic "encryption" {
    for_each = var.default_kms_key_name != null ? [1] : []
    content {
      default_kms_key_name = var.default_kms_key_name
    }
  }

  versioning {
    enabled = var.versioning_enabled
  }
  labels = local.gcs_labels
}