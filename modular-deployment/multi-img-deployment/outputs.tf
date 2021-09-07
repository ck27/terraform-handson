output "container_access" {
  value = [
    for ctr in module.container[*] : ctr
  ]
  description = "Host and port of each container"
}