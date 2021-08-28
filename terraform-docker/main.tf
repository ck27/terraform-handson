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
  count = 2
  name = join("-", [
    "nodered",
    random_string.random[count.index].result
    ]
  )
  image = docker_image.nodered_img.latest

  ports {
    internal = 1880
  }
}

resource "random_string" "random" {
  length  = 6
  special = false
  upper   = false
  count   = 2
}

output "ip_address_out" {
  value = [for ctr in docker_container.nodered_ctr : join( ":", [ "http://", ctr.ip_address, ctr.ports[0].external ] )]
}

output "ip_address_out_with_splat" {
  value = [for ctr in docker_container.nodered_ctr[*]: join(":", ["http://",ctr.ip_address], ctr.ports[*].external ) ]
}

output "container_name" {
  value = docker_container.nodered_ctr[*].name
}

