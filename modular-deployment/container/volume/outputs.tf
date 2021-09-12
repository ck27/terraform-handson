output "volume_out" {
  value = docker_volume.ctr_volume[*].name
}