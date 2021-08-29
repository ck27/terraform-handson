module "image_mod" {
  source = "../image"
}

module "container_mod" {
  source   = "../container"
  image_in = module.image_mod.image_out
  name_in = join("-", [
    "nodered",
    terraform.workspace,
    random_string.random[count.index].result
    ]
  )

  int_port_in = var.internal_port
  ext_port_in = var.external_port[terraform.workspace][count.index]
  count       = local.port_count
}

resource "random_string" "random" {
  length  = 6
  special = false
  upper   = false
  count   = local.port_count
}

