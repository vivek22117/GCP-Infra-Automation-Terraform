#####======================== GCP authentication variables ==========================#####
variable "gcp_auth_file" {
  type        = string
  description = "GCP authentication file"
}

variable "gcp_region" {
  type        = string
  description = "GCP region"
}

variable "gcp_project" {
  type        = string
  description = "GCP project name"
}

#####===========================backend gcs configuration=================================#####
variable "bucket_name_prefix" {
  type        = string
  description = "The prefix to the name of the Google Storage Bucket to create"
}
variable "storage_class" {
  type        = string
  description = "The storage class of the Storage Bucket to create, valid values `STANDARD`, `MULTI_REGIONAL`, `REGIONAL`, `NEARLINE`, `COLDLINE`, `ARCHIVE`"
}

variable "force_destroy" {
  type        = bool
  description = "When deleting a bucket, this boolean option will delete all contained objects."
}

variable "versioning_enabled" {
  type        = bool
  description = "While set to `true`, versioning is fully enabled for this bucket."
}


variable "retention_policy" {
  type = object({
    is_locked        = bool
    retention_period = number
  })
  default     = null
  description = <<-DOC
    Configuration of the bucket's data retention policy for how long objects in the bucket should be retained.
      is_locked:
        If set to `true`, the bucket will be locked and permanently restrict edits to the bucket's retention policy.
      retention_period:
        The period of time, in seconds, that objects in the bucket must be retained and cannot be deleted, overwritten, or archived.
  DOC
}

variable "default_kms_key_name" {
  type        = string
  default     = null
  description = "The `id` of a Cloud KMS key that will be used to encrypt objects inserted into this bucket, if no encryption method is specified."
}


######################################################
# Local variables defined                            #
######################################################
variable "team" {
  type        = string
  description = "Owner team for this application infrastructure"
}

variable "owner" {
  type        = string
  description = "Owner of the product"
}

variable "environment" {
  type        = string
  description = "Environment to be used"
}

variable "component" {
  type = string
  description = "Project component for which resources are created"
}
