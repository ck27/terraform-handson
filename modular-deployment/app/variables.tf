locals {
  port_count = length(var.external_port[terraform.workspace])
}

variable "external_port" {
  type = map(any)
}

variable "internal_port" {
  default = 1880
}