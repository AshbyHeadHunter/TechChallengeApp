#Set our variables for the DB module

variable "instance_class" {
  type    = string
  default = "db.t3.medium"
}

variable "app_name" {
  type = string
}

variable "node_count" {
  type    = number
  default = 1
}

variable "db_name" {
  type = string
}

variable "db_user" {
  type = string
}

variable "db_password" {
  type = string
}

variable "subnets" {
  type = list
}

variable "vpc" {}
