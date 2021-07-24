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

  backend "gcs" {
    bucket = "doubledigit-tfstate-us-west2-dev"
    prefix = "state/dev/backend/terraform.tfstate"
    credentials = "C:\\Users\\vivek\\GCP\\auth\\dd-solutions-71ecc944d35c.json"
  }
}