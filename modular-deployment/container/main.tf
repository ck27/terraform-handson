resource "docker_container" "container" {
  image = var.image_in
  name = var.name_in

  ports {
    internal = var.int_port_in
    external = var.ext_port_in
  }

  volumes {
    container_path = var.container_path_in
    volume_name = docker_volume.ctr_volume.name
  }
}

resource "docker_volume" "ctr_volume" {
  name = "${var.name_in}-vol"
}

