resource "random_string" "random" {
  count   = var.count_in
  length  = 4
  special = false
  upper   = false
}
resource "docker_container" "container" {
  count = var.count_in
  image = var.image_in
  name = join("-", [
    var.name_in,
    terraform.workspace,
    random_string.random[count.index].result
  ])

  ports {
    internal = var.int_port_in
    external = var.ext_port_in[count.index]
  }

  dynamic "volumes" {
    for_each = var.volumes_in
    content {
      container_path = volumes.value["container_path_each"]
      volume_name    = module.volume[count.index].volume_out[volumes.key]
    }
  }

  provisioner "local-exec" {
    command = "echo ${self.name} : ${self.ip_address}:${join("", [for x in self.ports[*]["external"] : x])} >> containers.txt"
  }

  provisioner "local-exec" {
    command = "rm -rf containers.txt"
    when    = destroy
  }
}

module "volume" {
  source       = "./volume"
  count        = var.count_in
  volume_count = length(var.volumes_in)
  volume_name  = "${var.name_in}-${terraform.workspace}-${random_string.random[count.index].result}-vol"
}

