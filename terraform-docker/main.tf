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
  name = "nodered/node-red:latest-minimal"
}

resource "docker_container" "nodered_ctr" {
  name = "nodered_ctr"
  image = docker_image.nodered_img.latest

  ports {
    internal = 1880
    external = 1880
  }
}

output "ip_address_out" {
  value = docker_container.nodered_ctr.ip_address
}

output "container_name" {
  value = docker_container.nodered_ctr.name
}

output "container_id" {
  value = docker_container.nodered_ctr.id
}