variable "container_count" {
  default = 1
}

variable "images" {
  type = map(any)

  default = {
    "dev" : "nodered/node-red:latest",
    "prod" : "nodered/node-red:latest-minimal"
  }
}

variable "internal_port" {
  validation {
    condition     = var.internal_port == 1880
    error_message = "The internal port for the container is 1880 and cannot be modified."
  }
}

locals {
  port_count = length(var.external_port[terraform.workspace])
}

variable "external_port" {
  type = map

  validation {
    condition     = min(var.external_port["dev"]...) > 0 && max(var.external_port["dev"]...) <= 65535
    error_message = "The external port for the container must be with range 0 - 65535."
  }

  validation {
    condition     = min(var.external_port["prod"]...) > 0 && max(var.external_port["prod"]...) <= 65535
    error_message = "The external port for the container must be with range 0 - 65535."
  }
}