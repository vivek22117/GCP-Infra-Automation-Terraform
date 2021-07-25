variable "gcp_region" {
  type        = string
  description = "GCP region"
}

variable "gcp_project" {
  type        = string
  description = "GCP project name"
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
  type = string
  description = "Project component for which resources are created"
}

#####==============================VPC Configuration Variables==============================#####
variable "public_subnet_with_cidr" {
  type = map(string)
  description = "CIDR range with region for private subnetwork"
  default = {
    us-east1 = "10.1.0.0/20"
    us-west1 = "10.3.0.0/20"
  }
}

variable "private_subnet_with_cidr" {
  type = map(string)
  description = "CIDR range with regions for private subnetwork"
  default = {
    us-east1 = "10.0.0.0/20"
    us-west1 = "10.2.0.0/20"
  }
}

variable "srv_account_name" {
  type = string
  description = "The Google service account ID"
}

