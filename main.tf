terraform {
  required_providers {
    oci = {
      source = "hashicorp/oci"
    }
  }
}

resource "random_string" "deployment_id" {
  length  = 5
  upper   = false
  lower   = true
  numeric = true
  special = false
}

data "oci_identity_compartment" "this" {
    id = var.compartment_id
}
