resource "oci_core_local_peering_gateway" "acceptor" {
  count          = length(var.local_peering_acceptor)
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.this.id
  display_name   = "acceptor-${random_string.deployment_id.result}"
  depends_on = [
    oci_identity_policy.acceptor_policy
  ]
}

resource "oci_identity_policy" "acceptor_policy" {
  count          = length(var.local_peering_acceptor)
  name           = "Acceptor-Policy-${random_string.deployment_id.result}"
  description    = "Acceptor policy"
  compartment_id = var.local_peering_root_compartment_ocid
  statements = [
    "Define tenancy Requestor as ${var.local_peering_acceptor[count.index].requestor_tenancy_ocid}",
    "Define group RequestorGroup as ${var.local_peering_acceptor[count.index].requestor_group_ocid}",
    "Admit group RequestorGroup of tenancy Requestor to manage local-peering-to in compartment Zelos",
    "Admit group RequestorGroup of tenancy Requestor to associate local-peering-gateways in tenancy Requestor with local-peering-gateways in compartment Zelos"
  ]
}
