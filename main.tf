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

data "oci_identity_groups" "administrators" {
    compartment_id = var.local_peering_root_compartment_ocid
    name = "Administrators"
}