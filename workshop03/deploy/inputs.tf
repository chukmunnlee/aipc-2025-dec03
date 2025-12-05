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
   default = "s-2vcpu-4gb"
}

variable DO_IMAGE {
   type = string
   default = "ubuntu-24-04-x64"
}

variable DO_SSH_PUB_KEY {
   type = string
}

variable DO_SSH_PRIV_KEY {
   type = string
   sensitive = true
}

variable CF_API_TOKEN {
   type = string 
   sensitive = true
}
variable CF_ZONE_ID {
   type = string
}

variable CS_DOMAIN_NAME {
   type = string
   default = "code-server"
}
variable CS_PASSWORD {
   type = string
}
