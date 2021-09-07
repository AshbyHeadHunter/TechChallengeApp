# Intro
We are using Terraform to deploy the application to AWS. Terraform will deploy a VPC along with public and private subnets, an application load balancer sits within the public subnet while ECS (Fargate) and Aurora cluster sit within the private subnet to prevent public access.

# Architecture
Terraform will create the following:

- VPC for the application [See terraform module here](https://github.com/AshbyHeadHunter/TechChallengeApp/tree/master/terraform/modules/vpc)
  - Private and Public subnets, route tables, Internet Gateway etc.
- Postgres Aurora RDS [See terraform module here](https://github.com/AshbyHeadHunter/TechChallengeApp/tree/master/terraform/modules/db)
  - Aurora gives us the ability to create DB clusters for high availiability
  - Sites within the private subnet thus not allowing it to be publically accessable and requires you to be within the VPC to access it.
- Load balancer (listenting port 80, open to the world, change whitelisted_cidr varaible in variables.tf to restric access via IP) [See terraform module here](https://github.com/AshbyHeadHunter/TechChallengeApp/tree/master/terraform/modules/ecs)
  - Application Load balancer sits in public subnet and allows external traffic to come through and to the Application
- Create a ECS cluster
- Create a ECS service
- Create a ECS tasks passing in database creditials

**TLDR;** The application is deployed to AWS using AWS Fargate in ECS to run the container. As the containers are inside the VPC they have access to the Aurora DB Cluster sitting in the private subnet. The load balanace will provide access to the containers running on port 3000 cia port 80 publically.

# Requirements
You will need to follow the below to be able to deploy this application

## Getting Started:
- Install terraform 1.0.x https://learn.hashicorp.com/tutorials/terraform/install-cli
- Install AWS CLI https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html
- Configure AWS profile: https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html

## Configuration

- `cd deployment`
- Update [variables.tf](https://github.com/AshbyHeadHunter/TechChallengeApp/blob/master/terraform/deployment/variables.tf) with relevent values
  - app_name: 
    - The name of your app, make sure that it is short as this is used when creating infrastructure and if it is to long will result in errors such as "Error: "name" cannot be longer than 32 characters: "TechChallengeApp-ecs-load-balancer"" where "TechChallengeApp" has been set as the default for app_name
    - ensure that app_name also uses lowercase as this is a requirement for some aws resources
  - Tags:
    - Add any tags here that you would like added to your resources
  - app_port:
    - No need to really change this its the port the apps container uses and we map our host and alb to it
  - whitelisted_cidr:
    - the CIDR range to whitelist access to the application. Currently set to be open to the world but you can change this if you want to keep it restricted to a single or multiple ips. Simply list out your ips like this ["x.x.x.x/32","y.y.y.y/32","a.a.a.a/32"]
  - image_repository: 
      - Set the image repository to use for the containers. This is in reference to a docker hub repository. Useful if you want to build, manage and use your own container images.
  - db_user:
      - Specify a database user - this is used when creating the RDS as well as inserted into the apps config
  - db_password:
      - Specify a database password - this is used when creating the RDS as well as inserted into the apps config
  - db_name:
      - Specify a database name - this is used when creating the RDS as well as inserted into the apps config
  - **NB:** There are many other vairables that can be overriden. If you look at the [main.tf](https://github.com/AshbyHeadHunter/TechChallengeApp/blob/master/terraform/deployment/main.tf) file you will see how they are used.
- If required, update S3 bucket or profile in [main.tf](https://github.com/AshbyHeadHunter/TechChallengeApp/blob/master/terraform/deployment/main.tf).
  - You will  need to create the S3 Bucket and update [main.tf](https://github.com/AshbyHeadHunter/TechChallengeApp/blob/master/terraform/deployment/main.tf) terraform backend provider
- Initialise state file: `terraform init`
- Apply `terraform apply`

