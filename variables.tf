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

variable "local_peering_id" {
  type    = string
  default = ""
}

variable "local_peering_root_compartment_ocid" {
  type    = string
  default = ""
}

variable "local_peering_requestors" {
  type    = list(string)
  default = []
}

variable "local_peering_requestor_data" {
  type    =  map(object({
    acceptor_tenancy_ocid = string
    acceptor_cidr = string
  }))
  default = {}
}

variable "local_peering_acceptors" {
  type    = list(string)
  default = []
}

variable "local_peering_acceptor_data" {
  type    =  map(object({
    requestor_tenancy_ocid = string
    requestor_group_ocid = string
    requestor_cidr = string
  }))
  default = {}
}


