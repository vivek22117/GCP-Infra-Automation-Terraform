provider "google" {
  credentials = file(var.gcp_auth_file)
}


terraform {

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
  }
}