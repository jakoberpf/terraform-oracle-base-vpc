output "vcn_id" {
  value = oci_core_vcn.this.id
}

output "private_subnet_ids" {
  value = [for s in oci_core_subnet.private : s.id]
}

output "public_subnet_ids" {
  value = [for s in oci_core_subnet.public : s.id]
}

