variable "app_name" {}
variable "tags" {}

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
variable "cidr_public_a" {}
variable "cidr_public_b" {}
variable "cidr_public_c" {}
variable "cidr_private_a" {}
variable "cidr_private_b" {}
variable "cidr_private_c" {}