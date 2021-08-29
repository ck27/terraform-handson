variable "container_count" {
  default = 1
}

variable "internal_port" {
  default = 1880

  validation {
      condition = var.internal_port == 1880
      error_message = "The internal port for the container is 1880 and cannot be modified."
  }
}

variable "external_port" {
  default = 1880

  validation {
      condition = var.external_port > 0 && var.external_port <= 65535
      error_message = "The external port for the container must be with range 0 - 65535."
  }
}