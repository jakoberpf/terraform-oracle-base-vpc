resource "oci_core_subnet" "private" {
  for_each                   = toset(var.availability_domains)
  availability_domain        = each.value
  cidr_block                 = "192.168.7${index(var.availability_domains, each.value)}.0/24"
  display_name               = "${var.name}-private-subnet-${index(var.availability_domains, each.value)}-${random_string.deployment_id.result}"
  prohibit_public_ip_on_vnic = true
  dns_label                  = "${var.name}Private${index(var.availability_domains, each.value)}"
  compartment_id             = var.compartment_id
  vcn_id                     = oci_core_vcn.this.id
  route_table_id             = oci_core_default_route_table.this.id
  security_list_ids = [
    oci_core_security_list.this.id
  ]
  dhcp_options_id = oci_core_vcn.this.default_dhcp_options_id
}

resource "oci_core_subnet" "public" {
  for_each                   = toset(var.availability_domains)
  availability_domain        = each.value
  cidr_block                 = "192.168.8${index(var.availability_domains, each.value)}.0/24"
  display_name               = "${var.name}-public-subnet-${index(var.availability_domains, each.value)}-${random_string.deployment_id.result}"
  prohibit_public_ip_on_vnic = false
  dns_label                  = "${var.name}Public${index(var.availability_domains, each.value)}"
  compartment_id             = var.compartment_id
  vcn_id                     = oci_core_vcn.this.id
  route_table_id             = oci_core_default_route_table.this.id
  security_list_ids = [
    oci_core_security_list.this.id
  ]
  dhcp_options_id = oci_core_vcn.this.default_dhcp_options_id
}
