output lbaas_hostname {
  value = ibm_lbaas.lbaas.vip
}

output health_monitors {
  value = ibm_lbaas.lbaas.health_monitors
}

output "schematics_workspace_id" {
    value = [for x in split(",", chomp(module.shell_execute.stdout)): split(":", x)[1] if contains(split(":", x), "Schematics")][0]
}
