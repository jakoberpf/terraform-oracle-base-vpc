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
