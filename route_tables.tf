resource "oci_core_default_route_table" "this" {
  manage_default_resource_id = oci_core_vcn.this.default_route_table_id

  route_rules {
    destination       = "0.0.0.0/0"
    network_entity_id = oci_core_internet_gateway.this.id
  }
}

# resource "oci_core_route_table" "acceptor_route_table" {
#   count          = length(var.local_peering_acceptor)
#   compartment_id = var.compartment_id
#   vcn_id         = oci_core_vcn.this.id
#   display_name   = "acceptorRouteTable"
#   route_rules {
#     cidr_block = var.local_peering_acceptor[count.index].acceptor_cidr
#     network_entity_id = oci_core_local_peering_gateway.acceptor[count.index].id
#   }
#   depends_on = [
#     oci_identity_policy.acceptor_policy
#   ]
# }

# resource "oci_core_route_table" "requestor_route_table" {
#   count          = length(var.local_peering_requestor)
#   compartment_id = var.compartment_id
#   vcn_id         = oci_core_vcn.this.id
#   display_name   = "requestorRouteTable"
#   route_rules {
#     cidr_block = var.local_peering_acceptor[count.index].requestor_cidr
#     network_entity_id = oci_core_local_peering_gateway.requestor[count.index].id
#   }
#   depends_on = [
#     oci_identity_policy.requestor_policy
#   ]
# }