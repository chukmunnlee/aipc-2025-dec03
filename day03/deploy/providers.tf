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

   backend "s3" {
      // disable all checks for S3 compatible storage
      skip_credentials_validation = true
      skip_metadata_api_check = true
      skip_region_validation = true 
      skip_requesting_account_id = true 
      skip_s3_checksum = true

      endpoints = {
        s3 = "https://sgp1.digitaloceanspaces.com"
      }
      region = "sgp1"
      bucket = "aipcdec03"
      key = "day03/terraform.tfstate"
      // secret and access keys sourced from s3_backend.hcl
   }
}

provider "digitalocean" {
   // Needs to be configured with an API
   token = var.DO_TOKEN
}

provider "local" {
}