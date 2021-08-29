variable "container_count" {
  default = 1
}

variable "internal_port" {
  validation {
      condition = var.internal_port == 1880
      error_message = "The internal port for the container is 1880 and cannot be modified."
  }
}

locals {
  port_count = length(var.external_port)
}

variable "external_port" {
  type = list(number)

  validation {
      condition = min(var.external_port...) > 0 && max(var.external_port...) <= 65535
      error_message = "The external port for the container must be with range 0 - 65535."
  }
}