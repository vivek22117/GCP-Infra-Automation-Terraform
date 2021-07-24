provider "google" {
  region = "us-west2"
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
}