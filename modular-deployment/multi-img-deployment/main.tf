locals {
  deployment = {
    nodered = {
      container_count = length(var.external_port["nodered"][terraform.workspace])
      image           = var.image_in["nodered"][terraform.workspace]
      int_port        = 1880
      ext_port        = var.external_port["nodered"][terraform.workspace]
      volumes = [
        { container_path_each = "/data" }
      ]
    }
    influxdb = {
      container_count = length(var.external_port["influxdb"][terraform.workspace])
      image           = var.image_in["influxdb"][terraform.workspace]
      int_port        = 8086
      ext_port        = var.external_port["influxdb"][terraform.workspace]
      volumes = [
        { container_path_each = "/var/lib/influxdb" }
      ]
    }
    grafana = {
      container_count = length(var.external_port["grafana"][terraform.workspace])
      image           = var.image_in["grafana"][terraform.workspace]
      int_port        = 3000
      ext_port        = var.external_port["grafana"][terraform.workspace]
      volumes = [
        { container_path_each = "/var/lib/grafana" },
        { container_path_each = "/etc/grafana" }
      ]
    }
  }
}



module "image" {
  source   = "../image"
  for_each = local.deployment
  image_in = each.value.image
}

module "container" {
  source = "../container"

  for_each    = local.deployment
  name_in     = each.key
  image_in    = each.value.image
  int_port_in = each.value.int_port
  ext_port_in = each.value.ext_port
  volumes_in  = each.value.volumes
  count_in    = each.value.container_count
}
