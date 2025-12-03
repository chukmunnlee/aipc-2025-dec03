data "digitalocean_ssh_key" "mykey" {
   name = "cmlee_dec04"
}

resource "digitalocean_droplet" "mydroplet" {
   name = "mydroplet"
   image = var.DO_IMAGE
   size = var.DO_SIZE
   region = var.DO_REGION
   ssh_keys = [ data.digitalocean_ssh_key.mykey.id ]

   // Create a SSH connection
   connection {
     type = "ssh"
     user = "root"
     private_key = file("../../cmlee_ed25519")
     host = self.ipv4_address
   }

   provisioner "remote-exec" {
      inline = [
         "mkdir /opt/tmp",
         "apt update",
         "apt upgrade -y"
      ]
   }
   provisioner "file" {
      source = "./dep.png"
      destination = "/opt/tmp/dep.png"
   }
}

output "cmlee_ssh_key_fingerprint" {
   description = "cmlee dec04 ssh key fingerprint"
   value = data.digitalocean_ssh_key.mykey.fingerprint
}

output "mydroplet_ipv4" {
   value = digitalocean_droplet.mydroplet.ipv4_address
}