Candidates should take care to ensure that their submission meets the following criteria:

- Must be able to start from a cloned git repo.
  - Done by cloning repo, follow prerequsites in README for setup i.e. installing aws cli and terraform
- Must document any pre-requisites clearly.
  - See README.md
- Must be contained within a GitHub repository.
  - See https://github.com/AshbyHeadHunter/TechChallengeApp
- Must deploy via an automated process.
  - ToDO setup with Github Actions
- Must deploy infrastructure using code.
  - Using Terraform

### Grading

Candidates will be assessed across the following categories:

#### Coding Style

- Clarity of code
- Comments where relevant
- Consistency of Coding

#### Security

- Network segmentation (if applicable to the implementation)
  - Public subnets and private subnets used. ECS and RDS sits in private subnet while the application load balancer sits in the public. 
- Secret storage 
  - If i get this into a github action then Id store secrets in GITHUB to start with
  - Ideally use something like Vault from Hashicorp or AWS Secrets manager
- Platform security features

#### Simplicity

- No superfluous dependencies
- Do not overengineer the solution

#### Resiliency

- Auto scaling and highly available frontend
- Highly available Database
  - Built in aurora, even though by default this will deploy 1 in the cluster easily change to deploy multiple.



# TODO:
- [ ] Create Github actions 
- [ ] make rds instance_class a variable in the deployment varaibles to easily change it 
- [ ] in the ECS module look at secruity group for the ALB and get the ingress to use whitelist variable
- [ ] Secret store - This can be managed by GIT secrets when the Github action is setup