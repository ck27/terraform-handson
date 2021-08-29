output "ip_address_out" {
  value = [for ctr in docker_container.nodered_ctr : join(":", ["http://", ctr.ip_address, ctr.ports[0].external])]
}

output "ip_address_out_with_splat" {
  value = [for ctr in docker_container.nodered_ctr[*] : join(":", ["http://", ctr.ip_address], ctr.ports[*].external)]
}

output "container_name" {
  value = docker_container.nodered_ctr[*].name
}