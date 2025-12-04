data "digitalocean_ssh_key" "cmlee_dec04" {
  name = var.DO_SSH_PUB_KEY
}

resource "digitalocean_droplet" "codeserver" {
  name     = "codeserver"
  size     = var.DO_SIZE
  image    = var.DO_IMAGE
  region   = var.DO_REGION
  ssh_keys = [data.digitalocean_ssh_key.cmlee_dec04.id]
}

resource "local_file" "inventory" {
  filename = "inventory.yaml"
  file_permission = "0600"
  content = templatefile("inventory.yaml.tftpl", {
    cs_user = "root"
    ssh_private_key_file = var.DO_SSH_PRIV_KEY
    cs_password = var.CS_PASSWORD
    droplet_ip = digitalocean_droplet.codeserver.ipv4_address
  })
}

resource "local_file" "add_host" {
  filename = "add_host.sh"
  file_permission = "0555"
  content = "/bin/sh -c 'ssh-keyscan ${digitalocean_droplet.codeserver.ipv4_address} >> ~/.ssh/known_hosts'"
}

output "codeserver_ip" {
  value = digitalocean_droplet.codeserver.ipv4_address
}
