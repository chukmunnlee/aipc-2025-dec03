variable DO_TOKEN {
   type = string 
   sensitive = true
}

variable DO_IMAGE {
   type = string
   default = "ubuntu-24-04-x64"
}

variable DO_SIZE {
   type = string
   default = "s-2vcpu-4gb"
}

variable DO_REGION {
   type = string
   default = "sgp1"
}

variable DO_SSH_USERNAME {
   type = string
   default = "root"
}

variable DO_SNAPSHOT {
   type = string
   default = "code-server"
}

variable CODE_SERVER_VERSION {
   type = string
}

source "digitalocean" "mydroplet" {
   api_token = var.DO_TOKEN
   image = var.DO_IMAGE
   size = var.DO_SIZE
   region = var.DO_REGION
   ssh_username = var.DO_SSH_USERNAME
   snapshot_name = var.DO_SNAPSHOT
}

build {
   sources = [
      "source.digitalocean.mydroplet"
   ]

   provisioner ansible {
      playbook_file = "playbook.yaml"
   }
}