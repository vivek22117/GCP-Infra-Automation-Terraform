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
  description = "The storage class of the Storage Bucket to create"
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

#####=============Local variables===============#####
locals {
  common_tags = {
    owner       = var.owner
    team        = var.team
    environment = var.environment
    component = var.component
  }
}