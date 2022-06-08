resource "oci_core_vcn" "this" {
  dns_label      = var.name
  cidr_block     = var.vcn_cidr_block
  compartment_id = var.compartment_id
  display_name   = "${var.name}-vcn-${random_string.deployment_id.result}"
  freeform_tags = {
    "ManagedBy" = "terraform"
    "UsedBy"    = "${var.name}"
  }
}
