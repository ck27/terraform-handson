output "container_name" {
  value = module.container_mod[*].container_name_out
}

output "container_ips" {
  value = flatten(module.container_mod[*].ip_address_out)
}