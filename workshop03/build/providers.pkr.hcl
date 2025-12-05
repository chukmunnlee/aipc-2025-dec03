packer {
  required_plugins {
      digitalocean = {
         version = ">= 1.0.4"
         source  = "github.com/digitalocean/digitalocean"
      }
      ansible = {
         version = "~> 1"
         source = "github.com/hashicorp/ansible"
      }
  }
}
