# https://docs.oracle.com/en-us/iaas/Content/Network/Tasks/localVCNpeering.htm#Step3
# https://blogs.oracle.com/cloud-infrastructure/post/automate-oracle-cloud-infrastructure-vcn-peering-with-terraform
# https://www.ateam-oracle.com/post/inter-tenancy-vcn-peering-using-lpgs

resource "oci_core_local_peering_gateway" "requestor" {
  depends_on = [
    oci_identity_policy.requestor_policy
  ]
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.this.id
  display_name   = "requstor-${random_string.deployment_id.result}"
  # peer_id        = "ocid1.localpeeringgateway.oc1.eu-frankfurt-1.aaaaaaaa7xsiasnzcoefb5hns5cy55npnhvqymdd5go4rnrdopvbewd6jq7a" # oci_core_local_peering_gateway.acceptor.id
}

resource "oci_core_local_peering_gateway" "acceptor" {
  depends_on = [
    oci_identity_policy.acceptor_policy
  ]
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.this.id
  display_name   = "acceptor-${random_string.deployment_id.result}"
  # peer_id        = "ocid1.localpeeringgateway.oc1.eu-frankfurt-1.aaaaaaaa7xsiasnzcoefb5hns5cy55npnhvqymdd5go4rnrdopvbewd6jq7a" # oci_core_local_peering_gateway.acceptor.id
}

data "oci_identity_compartment" "this" {
    id = var.compartment_id
}

resource "oci_identity_policy" "requestor_policy" {
  count          = length(var.local_peering)
  name           = "Requestor-Policy-${random_string.deployment_id.result}"
  description    = "Requestor Policy"
  compartment_id = var.local_peering_root_compartment_ocid
  statements = [
    "Define tenancy Acceptor as ${var.local_peering[count.index].acceptor_tenancy_ocid}",
    "Allow group Administrators to manage local-peering-from in compartment ${data.oci_identity_compartment.this.name}",
    "Endorse group Administrators to manage local-peering-to in tenancy Acceptor",
    "Endorse group Administrators to associate local-peering-gateways in compartment ${data.oci_identity_compartment.this.name} with local-peering-gateways in tenancy Acceptor"
  ]
}

resource "oci_identity_policy" "acceptor_policy" {
  count          = length(var.local_peering)
  name           = "Acceptor-Policy-${random_string.deployment_id.result}"
  description    = "Acceptor policy"
  compartment_id = var.local_peering_root_compartment_ocid
  statements = [
    "Define tenancy Requestor as ${var.local_peering[count.index].requestor_tenancy_ocid}",
    "Define group RequestorGroup as ${var.local_peering[count.index].requestor_group_ocid}",
    "Admit group RequestorGroup of tenancy Requestor to manage local-peering-to in compartment Zelos",
    "Admit group RequestorGroup of tenancy Requestor to associate local-peering-gateways in tenancy Requestor with local-peering-gateways in compartment Zelos"
  ]
}
