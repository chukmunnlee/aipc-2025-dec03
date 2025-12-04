terraform {
  required_version = "1.14.0"
  required_providers {
    digitalocean = {
       source = "digitalocean/digitalocean"
       version = "2.69.0"
    }
    local = {
       source = "hashicorp/local"
       version = "2.6.1"
    }
  }
}

provider "digitalocean" {
  token = var.DO_TOKEN
}

provider "local" { }
