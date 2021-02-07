output lbaas_hostname {
  value = ibm_lbaas.lbaas.vip
}

output health_monitors {
  value = ibm_lbaas.lbaas.health_monitors
}

output "env_values" {
    value = [for x in split(",", chomp(data.local_file.env_info.content)): split(":", x)[1] if contains(split(":", x), "Schematics")][0]
}
