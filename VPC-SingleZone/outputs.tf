output instance_ips {
  value = ibm_is_instance.instance[*].primary_network_interface[0].primary_ipv4_address
}

output floating_ip {
  value = ibm_is_floating_ip.fip.address
}