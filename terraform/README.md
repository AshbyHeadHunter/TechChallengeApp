# Deployment via Terraform

This section contains all the relevent IaC to deploy the applicaiton into AWS.

## Gettings started

- Install terraform 1.0.x https://learn.hashicorp.com/tutorials/terraform/install-cli
- Install AWS CLI https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html
- Configure AWS profile: https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html

## Configuration

- `cd deployment`
- Update variables.tf with relevent values
- If required, update S3 bucket or profile in main.tf
-- You will  need to create the S3 Bucket and update main.tf terraform backend provider
- Initialise state file: `terraform init`
- Apply `terraform apply`

## NOTES
- keep the app name short as it is used in cases that can exceed the 32 max character limit resulting in errors such as "Error: "name" cannot be longer than 32 characters: "TechChallengeApp-ecs-load-balancer"" where "TechChallengeApp" has been set as the default for app_name
- ensure that app_name also uses lowercase as this is a requirement for some aws resources


## Design

Terraform will create the following:

- VPC for the application, subnets, routing tables, etc.
- Postgres Aurora RDS
- Load balancer (listenting port 80, open to the world)
- Create a ECS cluster
- Create a ECS service
- Create a ECS tasks passing in database creditials

The application will be deployed into AWS Fargate to run the container. The containers will have access to the Aurora DB. The load balancer will provide access to the container ports 3000 via port 80 publicly.

## Database

The database will need to be initally created by running a task with the `updatedb` command.

## Accessing the app

The application should be accessable via the Load balancer DNS.


## TODO 
Create Github CI/CD pipelines to automate and reduce need for users to clone and setup environemnt