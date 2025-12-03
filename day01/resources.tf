
resource "docker_image" "nginx_image" {
   name = "nginx:1.29"
}

//resource "docker_container" "nginx" {
//   // meta argument
//   count = 5
//   name = "mynginx-${count.index}"
//   image = docker_image.nginx_image.image_id
//   // -p 8080:80
//   ports {
//      internal = 80
//      external = 8080 + count.index
//   }
//}
resource "docker_container" "nginx" {
   // meta argument
   for_each = var.my_images
   name = each.key
   image = docker_image.nginx_image.image_id
   // -p 8080:80
   ports {
      internal = each.value.internal_port
      external = each.value.external_port
   }
}

//output nginx_ipv4 {
   //value = join(",", flatten(docker_container.nginx[*].network_data[*].ip_address))
//}