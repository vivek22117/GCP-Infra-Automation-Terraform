provider "google" {
  credentials = file(var.gcp_auth_file)
  project = var.gcp_project
  region = var.gcp_region
}


terraform {

  required_version = ">= 0.12"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 3.66"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.1"
    }
  }
}