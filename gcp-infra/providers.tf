provider "google" {
  region = "us-west2"
}

resource "random_integer" "suffix" {
  max = 100
  min = 1000000
}


terraform {

  required_providers {
    google = {
      source = "hashicorp/google"
      version = "~> 3.66"
    }

    random = {
      source = "hashicorp/random"
      version = "~> 3.1"
    }
  }
}