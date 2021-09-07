variable "app_name" {
  description = "Name of your Application"
  type        = string
  default     = "techchallenge"
}
variable "tags" {
  description = "Set your own custom tags"
  default = {
    "environment" = "techchallenge",
    "owner"       = "James Ashworth",
    "contact"     = "james@ashbys.com.au"
  }
}
variable "app_port" {
  description = "The port that the containers run on."
  default = 3000
}
variable "whitelisted_cidr" {
  description = "List the CIDR Ranges that are allowed access to the application"
  default = ["0.0.0.0/0"]
}
variable "image_repository" {
  description = "Docker Image repository to use for the Containers"
  default = "codingric/servian"
}
variable "db_user" {
  description = "Set the Database Username, used when creating the Aurora Cluster but also used to configure the application"
  default = "servian"
}
variable "db_password" {
  description = "Set the Database Password, used when creating the Aurora Cluster but also used to configure the application"
  default = "serviantest"
}
variable "db_name" {
  description = "Set the Database Name, used when creating the Aurora Cluster but also used to configure the application"
  default = "servian"
}
