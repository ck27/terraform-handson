
# output "ip_address_out" {
#   value = [for ctr in docker_container.nodered_ctr[*] : join(":", ["http://", ctr.ip_address], ctr.ports[*].external)]
# }

# output "container_name_out" {
#   value = docker_container.container.name[*]
# }

output "container_access" {
  value = { for ctr in docker_container.container[*]: ctr.name => join(":",[
    ctr.ip_address, ctr.ports[0]["external"]
  ]) }
}

