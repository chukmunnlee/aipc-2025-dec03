// Lookup snapshot
data "digitalocean_image" "mynginx" {
   name = "my-nginx"
}

resource "digitalocean_droplet" "mynginx" {
   name = "mynginx"
   // Use the snapshot as your image
   image = data.digitalocean_image.mynginx.id
   size = "s-1vcpu-1gb"
   region = "sgp1"
   tags = [ "ubuntu", "nginx" ]
}

output mynginx_ip {
   value = digitalocean_droplet.mynginx.ipv4_address
}