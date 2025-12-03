resource "docker_network" "bgg-net" {
   name = "bgg-net"
}

resource "docker_volume" "data-vol" {
   name = "data-vol"
}

// images
resource "docker_image" "bgg-database" {
   name = "chukmunnlee/bgg-database:nov-2025"
}

resource "docker_image" "bgg-app" {
   name = "chukmunnlee/bgg-app:nov-2025"
}
resource "docker_image" "nginx" {
   name = "nginx:1.29"
}

// containers
resource "docker_container" "bgg-database" {
   name = "bgg-database"
   image = docker_image.bgg-database.image_id
   networks_advanced {
      name = docker_network.bgg-net.name
   }
   volumes {
     volume_name = docker_volume.data-vol.name
     container_path = "/var/lib/mysql"
   }
   ports {
     internal = 3306
   }
}

resource "docker_container" "bgg-app" {
   count = 3
   name = "bgg-app-${count.index}"
   image = docker_image.bgg-app.image_id
   env = [
      "BGG_DB_USER=root",
      "BGG_DB_HOST=${docker_container.bgg-database.name}",
      "BGG_DB_PASSWORD=${var.db_password}"
   ]
   networks_advanced {
      name = docker_network.bgg-net.name
   }
   ports {
     internal = 5000
   }
}

resource "docker_container" "nginx" {
   name = "nginx"
   image = docker_image.nginx.image_id
   ports {
      internal = 80
      external = 8080
   }
   networks_advanced {
      name = docker_network.bgg-net.name
   }
   volumes {
      // Need absolute path 
      host_path = abspath(local_file.nginx_conf.filename)
      container_path = "/etc/nginx/nginx.conf"
      read_only = true
   }
}

resource "local_file" "nginx_conf" {
   filename = "nginx.conf"
   file_permission = "0444"
   content = templatefile("nginx.conf.tftpl", {
      bggapp_names = docker_container.bgg-app[*].name,
      bggapp_port = 5000
   })
  
}