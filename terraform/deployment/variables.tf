variable "app_name" {
  type    = string
  default = "techchallenge"
}

variable "tags" {
  default = {
    "environment" = "techchallenge",
    "owner"       = "James Ashworth",
    "contact"     = "james@ashbys.com.au"
  }
}

variable "app_port" {
  default = 3000
}

variable "whitelisted_cidr" {
  default = "0.0.0.0/0"
}

variable "image_repository" {
  default = "codingric/servian"
}

variable "db_user" {
  default = "servian"
}

variable "db_password" {
  default = "serviantest"
}

variable "db_name" {
  default = "servian"
}
