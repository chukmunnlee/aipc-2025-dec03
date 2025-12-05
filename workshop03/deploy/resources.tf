// Lookup snapshot
data "digitalocean_image" "codeserver" {
   name = "code-server"
}

data "digitalocean_ssh_key" "cmlee_dec04" {
  name = var.DO_SSH_PUB_KEY
}
resource "digitalocean_droplet" "codeserver" {
   name = "my-codeserver"
   // Use the snapshot as your image
   image = data.digitalocean_image.codeserver.id
   size = var.DO_SIZE
   region = var.DO_REGION

   ssh_keys = [ data.digitalocean_ssh_key.cmlee_dec04.id ]

   connection {
     type = "ssh"
     user = "root"
     private_key = file(var.DO_SSH_PRIV_KEY)
     host = self.ipv4_address
   }

   provisioner "remote-exec" {
      inline = [  
         "sed -i 's/__REPLACE__/${var.CS_PASSWORD}/' /lib/systemd/system/code-server.service",
         "sed -i 's/__REPLACE__/${var.CS_DOMAIN_NAME}.chuklee.com/' /etc/nginx/sites-available/code-server.conf",
         "systemctl daemon-reload",
         "systemctl restart code-server.service",
         "systemctl restart nginx"
      ]
   }
}

resource "cloudflare_dns_record" "codeserver" {
   name = var.CS_DOMAIN_NAME
   zone_id = var.CF_ZONE_ID
   type = "A"
   ttl = 1
   content = digitalocean_droplet.codeserver.ipv4_address
   proxied = true
}

output codeserver_ip {
   value = digitalocean_droplet.codeserver.ipv4_address
}