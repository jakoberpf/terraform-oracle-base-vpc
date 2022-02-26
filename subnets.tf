resource "oci_core_subnet" "private" {
  availability_domain        = var.availability_domains[0]
  cidr_block                 = "192.168.71.0/24"
  display_name               = "${var.name}-private-subnet-${random_string.deployment_id.result}"
  prohibit_public_ip_on_vnic = true
  dns_label                  = "${var.name}Private"
  compartment_id             = var.compartment_id
  vcn_id                     = oci_core_vcn.this.id
  route_table_id             = oci_core_default_route_table.this.id
  security_list_ids = [
    oci_core_security_list.this.id
  ]
  dhcp_options_id = oci_core_vcn.this.default_dhcp_options_id
}

resource "oci_core_subnet" "public" {
  availability_domain        = var.availability_domains[0]
  cidr_block                 = "192.168.81.0/24"
  display_name               = "${var.name}-public-subnet-${random_string.deployment_id.result}"
  prohibit_public_ip_on_vnic = false
  dns_label                  = "${var.name}Public"
  compartment_id             = var.compartment_id
  vcn_id                     = oci_core_vcn.this.id
  route_table_id             = oci_core_default_route_table.this.id
  security_list_ids = [
    oci_core_security_list.this.id
  ]
  dhcp_options_id = oci_core_vcn.this.default_dhcp_options_id
}
