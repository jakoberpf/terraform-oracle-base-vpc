variable "name" {
  type = string
}

variable "compartment_id" {
  type = string
}

variable "availability_domains" {
  type = list(string)
}

variable "vcn_cidr_block" {
  type = string
  default = "10.0.0.0/16"
}

variable "local_peering_root_compartment_ocid" {
  type    = string
  default = ""
}

variable "local_peering_acceptor" {
  type    =  list(object({
    id = string
    requestor_tenancy_ocid = string
    requestor_group_ocid = string
    requestor_cidr = string
  }))
  default = []
}

variable "local_peering_requestor" {
  type    =  list(object({
    id = string
    acceptor_tenancy_ocid = string
    acceptor_cidr = string
  }))
  default = []
}
