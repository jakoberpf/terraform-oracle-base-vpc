resource "oci_core_local_peering_gateway" "acceptor" {
  for_each       = toset(var.local_peering_acceptors)
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.this.id
  display_name   = "acceptor-${each.value}-${random_string.deployment_id.result}"
  depends_on = [
    oci_identity_policy.acceptor_policy
  ]
}

resource "oci_identity_policy" "acceptor_policy" {
  for_each       = toset(var.local_peering_acceptors)
  name           = "Acceptor-Policy-${title(each.value)}-${random_string.deployment_id.result}"
  description    = "Acceptor Policy ${title(each.value)}"
  compartment_id = var.local_peering_root_compartment_ocid
  statements = [
    "Define tenancy Requestor as ${lookup(var.local_peering_acceptor_data, each.value, null).requestor_tenancy_ocid}",
    "Define group RequestorGroup as ${lookup(var.local_peering_acceptor_data, each.value, null).requestor_group_ocid}",
    "Admit group RequestorGroup of tenancy Requestor to manage local-peering-to in compartment Zelos",
    "Admit group RequestorGroup of tenancy Requestor to associate local-peering-gateways in tenancy Requestor with local-peering-gateways in compartment Zelos"
  ]
}
