variable DO_TOKEN {
   type = string 
   sensitive = true
}

variable DO_REGION {
   type = string
   default = "sgp1"
}

variable "DO_SIZE" {
   type = string 
   default = "s-1vcpu-1gb"
}

variable DO_IMAGE {
   type = string
   default = "ubuntu-24-04-x64"
}

variable my_images {
   type = map(
      object({
         image_name = string
         internal_port = number
         external_port = number
      })
   )
}