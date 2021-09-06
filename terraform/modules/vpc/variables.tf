##
## Required
##

variable "app_name" {}

variable "tags" {
  type    = map
  default = {}
}

####
## Defaults
####

variable "cidr_block" {
  default = "10.10.64.0/22"
}

variable "vpc_enable_dns_hostnames" {
  default = true
}

variable "availability_zone_a" {
  default = "ap-southeast-2a"
}

variable "availability_zone_b" {
  default = "ap-southeast-2b"
}

variable "availability_zone_c" {
  default = "ap-southeast-2c"
}

variable "route_public_cidr" {
  default = "0.0.0.0/0"
}

variable "cidr_public_a" {
  default = "10.10.64.0/27"
}

variable "cidr_public_b" {
  default = "10.10.64.32/27"
}

variable "cidr_public_c" {
  default = "10.10.64.64/27"
}

variable "cidr_private_a" {
  default = "10.10.64.96/27"
}

variable "cidr_private_b" {
  default = "10.10.64.128/27"
}

variable "cidr_private_c" {
  default = "10.10.64.160/27"
}
