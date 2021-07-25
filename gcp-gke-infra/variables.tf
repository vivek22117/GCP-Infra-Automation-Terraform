#####======================== GCP authentication variables ==========================#####
variable "gcp_auth_file" {
  type        = string
  description = "GCP authentication file"
}

variable "gcp_region" {
  type        = string
  description = "GCP region"
}

variable "org_id" {
  type        = string
  description = "GCP organisation ID"
}

variable "folder_id" {
  type        = string
  description = "GCP folder ID"
}

variable "billing_account" {
  type        = string
  description = "GCP billing account"
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
  type        = string
  description = "Project component for which resources are created"
}
