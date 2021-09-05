locals {
  deployment = {
    nodered = {
      image          = var.image_in["nodered"][terraform.workspace]
      int_port       = 1880
      ext_port       = var.external_port["nodered"][terraform.workspace]
      container_path = "/data"
    }
    influxdb = {
      image          = var.image_in["influxdb"][terraform.workspace]
      int_port       = 8086
      ext_port       = var.external_port["influxdb"][terraform.workspace]
      container_path = "/var/lib/influxdb"
    }
  }
}

resource "random_string" "random" {
  for_each = local.deployment
  length   = 4
  special  = false
  upper    = false
}

module "image" {
  source   = "../image"
  for_each = local.deployment
  image_in = each.value.image
}

module "container" {
  source = "../container"

  for_each = local.deployment
  name_in = join("-", [
    each.key,
    terraform.workspace, random_string.random[each.key].result
  ])
  image_in = each.value.image
  container_path_in = each.value.container_path
  int_port_in = each.value.int_port
  ext_port_in = each.value.ext_port[0]
}
