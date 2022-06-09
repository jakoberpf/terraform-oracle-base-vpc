output "vcn_id" {
  value = oci_core_vcn.this.id
}

output "private_subnet_ids" {
  value = [for s in oci_core_subnet.private : s.id]
}

output "public_subnet_ids" {
  value = [for s in oci_core_subnet.public : s.id]
}

output "local_peering_acceptor_gateway_ocid" {
  value = oci_core_local_peering_gateway.acceptor[*].id
}

output "local_peering_requestor_group_ocid" {
  value = data.oci_identity_groups.administrators.id
}
