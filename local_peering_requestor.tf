resource "oci_core_local_peering_gateway" "requestor" {
  count          = length(var.local_peering_requestor)
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.this.id
  display_name   = "requstor-${random_string.deployment_id.result}"
  # peer_id        = "ocid1.localpeeringgateway.oc1.eu-frankfurt-1.aaaaaaaa7xsiasnzcoefb5hns5cy55npnhvqymdd5go4rnrdopvbewd6jq7a" # oci_core_local_peering_gateway.acceptor.id
  depends_on = [
    oci_identity_policy.requestor_policy
  ]
}

data "oci_identity_compartment" "this" {
    id = var.compartment_id
}

data "oci_identity_groups" "administrators" {
    compartment_id = var.local_peering_root_compartment_ocid
    name = "Administrators"
}

resource "oci_identity_policy" "requestor_policy" {
  count          = length(var.local_peering_requestor)
  name           = "Requestor-Policy-${random_string.deployment_id.result}"
  description    = "Requestor Policy"
  compartment_id = var.local_peering_root_compartment_ocid
  statements = [
    "Define tenancy Acceptor as ${var.local_peering_requestor[count.index].acceptor_tenancy_ocid}",
    "Allow group Administrators to manage local-peering-from in compartment ${data.oci_identity_compartment.this.name}",
    "Endorse group Administrators to manage local-peering-to in tenancy Acceptor",
    "Endorse group Administrators to associate local-peering-gateways in compartment ${data.oci_identity_compartment.this.name} with local-peering-gateways in tenancy Acceptor"
  ]
}
