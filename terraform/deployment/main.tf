terraform {
  backend "s3" {
    bucket  = "terraform-techchallengeapp-dy2bfh"
    key     = "statefiles/servian.tfstate"
    region  = "ap-southeast-2"
    profile = "TechChallengeApp"
  }
}

provider "aws" {
  profile = "TechChallengeApp"
  region  = "ap-southeast-2"
}


data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "all" {
  vpc_id = data.aws_vpc.default.id
}

module "vpc" {
  source = "../modules/vpc"

  app_name = var.app_name

  tags = var.tags
}

module "deployment" {
  source = "../modules/ecs-deploy"

  app_name            = var.app_name
  app_image           = var.image_repository
  app_port            = var.app_port
  app_template        = "app.tmpl"
  vpc_id              = module.vpc.vpc_id
  public_subnet_ids   = module.vpc.public_subnets[*].id
  private_subnet_ids  = module.vpc.private_subnets[*].id
  aws_region          = "ap-southeast-2"
  allowed_cidr_blocks = [var.whitelisted_cidr]

  environment = [
    { name = "DBNAME", value = module.db.db_name },
    { name = "DBUSER", value = module.db.db_user },
    { name = "DBPASSWORD", value = module.db.db_password },
    { name = "DBHOST", value = module.db.db_host }
  ]
  tags = var.tags
}

module "db" {
  source = "../modules/db"

  app_name = var.app_name

  db_name     = var.db_name
  db_user     = var.db_user
  db_password = var.db_password

  vpc     = module.vpc.vpc
  subnets = module.vpc.private_subnets
}
