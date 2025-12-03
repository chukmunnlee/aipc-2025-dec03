terraform {
   required_version = "1.14.0"
   required_providers {
      local = {
         source = "hashicorp/local"
         version = "2.6.1"
      }
      digitalocean = {
         source = "digitalocean/digitalocean"
         version = "2.69.0"
      }
   }
}

provider "digitalocean" {
   // Needs to be configured with an API
   token = var.DO_TOKEN
}

provider "local" {
}