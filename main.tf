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
  number  = true
  special = false
}
