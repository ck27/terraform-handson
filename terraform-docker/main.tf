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
  name = var.images[terraform.workspace]
}

resource "docker_container" "nodered_ctr" {
  count = local.port_count
  name = join("-", [
    "nodered",
    terraform.workspace,
    random_string.random[count.index].result
    ]
  )
  image = docker_image.nodered_img.latest

  ports {
    internal = var.internal_port
    external = var.external_port[terraform.workspace][count.index]
  }
}

resource "random_string" "random" {
  length  = 6
  special = false
  upper   = false
  count   = local.port_count
}