provider "google" {
  project = var.gcp_project
  credentials = file(var.gcp_auth_file)
  region = var.gcp_region"us-west2"
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

  backend "gcs" {
    bucket = ""
    prefix = ""
    credentials = ""
  }
}