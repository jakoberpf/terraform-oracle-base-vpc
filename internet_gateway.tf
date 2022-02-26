resource "oci_core_internet_gateway" "this" {
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.this.id
  display_name   = "${var.name}-igw-${random_string.deployment_id.result}"
  enabled        = "true"
  freeform_tags = {
    "ManagedBy" = "terraform"
    "UsedBy"    = "${var.name}"
  }
}
