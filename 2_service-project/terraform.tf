terraform {
  cloud {}
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">=4.22"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = ">=4.22"
    }
    null = {
      source = "hashicorp/null"
      # version = "~> 2.1"
    }
    random = {
      source = "hashicorp/random"
      # version = "~> 2.2"
    }
  }
}
