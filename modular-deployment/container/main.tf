resource "docker_container" "nodered_ctr" {
  image = var.image_in
  name = var.name_in

  ports {
    internal = var.int_port_in
    external = var.ext_port_in
  }

  volumes {
    container_path = "/data"
    volume_name = docker_volume.ctr_volume.name
  }
}

resource "docker_volume" "ctr_volume" {
  name = "${var.name_in}-vol"
}

