data "digitalocean_ssh_key" "mykey" {
   name = var.DO_SSH_PUB_KEY
}

resource "digitalocean_droplet" "nginx" {
   name = "nginx"
   image = var.DO_IMAGE
   size = var.DO_SIZE
   region = var.DO_REGION
   ssh_keys = [ data.digitalocean_ssh_key.mykey.id ]

   // Create a SSH connection
   connection {
     type = "ssh"
     user = "root"
     private_key = file(var.DO_SSH_PRIV_KEY)
     host = self.ipv4_address
   }

   provisioner "remote-exec" {
      inline = [
         "apt update",
         "apt install nginx -y",
         "systemctl daemon-reload",
         "systemctl enable nginx",
         "systemctl start nginx",
      ]
   }

   provisioner "file" {
      content = templatefile("./assets/index.tftpl", {
         droplet_ip = self.ipv4_address
      })
      destination = "/var/www/html/index.html"
   }

   provisioner "file" {
      source = "./assets/hello.gif"
      destination = "/var/www/html/hello.gif"
   }
}

output "nginx_ipv4" {
   value = digitalocean_droplet.nginx.ipv4_address
}