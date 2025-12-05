variable DO_TOKEN {
   type = string 
   sensitive = true
}

source "digitalocean" "mydroplet" {
   api_token = var.DO_TOKEN
   image = "ubuntu-24-04-x64"
   size = "s-1vcpu-1gb"
   region = "sgp1"
   ssh_username = "root"
   snapshot_name = "my-nginx"
}

build {
   sources = [
      "source.digitalocean.mydroplet"
   ]

   provisioner ansible {
      playbook_file = "playbook.yaml"
   }
}