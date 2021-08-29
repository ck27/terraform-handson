terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "2.15.0"
    }
  }
}

provider "docker" {}


resource "docker_image" "nodered_img" {
  name = "nodered/node-red:latest"
}

resource "docker_container" "nodered_ctr" {
  count = var.container_count
  name = join("-", [
    "nodered",
    random_string.random[count.index].result
    ]
  )
  image = docker_image.nodered_img.latest

  ports {
    internal = var.internal_port
    external = var.external_port
  }
}

resource "random_string" "random" {
  length  = 6
  special = false
  upper   = false
  count   = var.container_count
}

