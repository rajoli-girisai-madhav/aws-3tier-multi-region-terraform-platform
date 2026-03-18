# AWS 3-Tier Architecture using Terraform

This project provisions a **3-Tier Architecture on AWS using
Terraform**.\
It automates the deployment of infrastructure components such as:

-   VPC
-   Public and Private Subnets
-   Security Groups
-   Application Load Balancers
-   Auto Scaling Groups
-   EC2 Instances
-   RDS Writer and Read Replica
-   S3 Backend for Terraform State

The infrastructure supports **multiple environments** using **Terraform
Workspaces**.

------------------------------------------------------------------------

# Project Structure

    .
    ├── root-module
    │   ├── terraformblock.tf
    │   ├── provider.tf
    │   ├── main.tf
    │   ├── variables.tf
    │   ├── outputs.tf
    │   ├── datasource.tf
    │   ├── amzninstall.sh
    │   └── <env>.tfvars
    │
    ├── vpc-module
    │   ├── vpc.tf
    │   ├── igw.tf
    │   ├── subnets.tf
    │   ├── route_tables.tf
    │   ├── subnets_association.tf
    │   ├── eip.tf
    │   ├── natgw.tf
    │   ├── datasource.tf
    │   ├── variables.tf
    │   └── outputs.tf
    │
    ├── sg-module
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    │
    ├── ASG-module
    │   ├── load_balancer.tf
    |   ├── target_group.tf
    |   ├── launch_template.tf
    |   ├── auto_scaling_group.tf
    │   ├── variables.tf
    │   └── outputs.tf
    │
    └── README.md

------------------------------------------------------------------------

# Deployment Workflow

``` mermaid
flowchart LR

A[Developer] --> B[Terraform Validate]
B --> C[Terraform Plan]
C --> D[Terraform Apply]

D --> E[AWS Infrastructure Created]

E --> F[VPC]
E --> G[Security Groups]
E --> H[Auto Scaling Groups]
E --> I[Load Balancers]
E --> J[RDS Writer]
E --> K[RDS Read Replica]
```

------------------------------------------------------------------------

# Tools Used

-   Terraform
-   AWS
-   Git
-   AWS CLI

![Terraform](https://img.shields.io/badge/Terraform-1.0+-purple)
![AWS](https://img.shields.io/badge/AWS-Cloud-orange)
![Infrastructure](https://img.shields.io/badge/Infrastructure-as--Code-blue)

------------------------------------------------------------------------

# Steps to Deploy the Infrastructure

## Step 1: Export AWS Credentials

``` bash
export aws_access_key="AKIA..."
export aws_secret_key="wJalr..."
```

------------------------------------------------------------------------

## Step 2: Create Terraform Workspaces

``` bash
terraform workspace new Develop
terraform workspace new Test
terraform workspace new Pre-prod
```

------------------------------------------------------------------------

## Step 3: Create `.tfvars` Files for Each Environment with below configurations.

Example:

    develop.tfvars
    test.tfvars
    preprod.tfvars

### Configuration for VPC and its components

    aws_region_name = "<AWS_REGION>"
    aws_profile_name = "<AWS_PROFILE_NAME>"

    vpc_cidr_block = "<CIDR_BLOCK>"
    public_subnet_cidr = ["CIDR1", "CIDR2"]
    app_tier_subnet_cidr = ["CIDR1", "CIDR2"]
    db_tier_subnet_cidr = ["CIDR1", "CIDR2"]

### Configuring Security Groups

Define inbound rules for **Web, App, and Database security groups** in the `.tfvars` file.

#### Web and App Tier Security Group Rules

Provide a `list(object)` defining inbound rules for both **Web Tier** and **App Tier** security groups.

```hcl
web_and_app_inbound_rules = [
  {
    port        = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow SSH access"
  },
  {
    port        = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow HTTP access"
  }
]
```

Structure of the object:

```hcl
list(object({
  port        = number
  protocol    = string
  cidr_blocks = list(string)
  description = string
}))
```

#### Database Tier Security Group Rules

Provide inbound rules for the **Database Tier Security Group**.

```hcl
db_inbound_rules = [
  {
    port        = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow SSH access"
  },
  {
    port        = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow MySQL access"
  }
]
```

The structure of each rule is the same as defined above.


### Configure Web Tier and App Tier

    web_alb_name = "<web_load_balancer_name>"
    web_alb_scheme = <false>
    web_tg_name = "<web-tier-target-group-name>"
    web_name_prefix = "<web-launch-template-name>"
    web_instance_type = "<instance-type>"
    web_name = "<web-tier-autoscaling-group-name>"
    web_min_size = <number>
    web_max_size = <number>
    web_desired_capacity = <number>
    web_tags = "<web-instances-common-name>"

    app_alb_name = "<app_load_balancer_name>"
    app_alb_scheme = <false>
    app_tg_name = "<app-tier-target-group-name>"
    app_name_prefix = "<app-launch-template-name>"
    app_instance_type = "<instance-type>"
    app_name = "<app-tier-autoscaling-group-name>"
    app_min_size = <number>
    app_max_size = <number>
    app_desired_capacity = <number>
    app_tags = "<app-instances-common-name>"

### Configure Database

    db_password = "<YOUR_DATABASE_PASSWORD>"

------------------------------------------------------------------------

## step-4: Complete Example `.tfvars` Configuration

Below is a complete example `.tfvars` file that can be used to deploy the infrastructure.

```hcl
################################
# AWS Configuration
################################

aws_region_name  = "ap-south-1"
aws_profile_name = "default"

################################
# VPC Configuration
################################

vpc_cidr_block = "132.0.0.0/16"

public_subnet_cidr = [
  "132.0.10.0/24",
  "132.0.30.0/24"
]

app_tier_subnet_cidr = [
  "132.0.50.0/24",
  "132.0.70.0/24"
]

db_tier_subnet_cidr = [
  "132.0.90.0/24",
  "132.0.110.0/24"
]

################################
# Security Group Rules
################################

web_and_app_inbound_rules = [
  {
    port        = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow SSH traffic"
  },
  {
    port        = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow HTTP traffic"
  }
]

db_inbound_rules = [
  {
    port        = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow SSH traffic"
  },
  {
    port        = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow MySQL traffic"
  }
]

################################
# Web Tier Configuration
################################

web_alb_name = "Web-Tier-ALB"
web_alb_scheme = false
web_tg_name = "web-tier-target-group"

web_name_prefix = "Web-Template"
web_instance_type = "t3.micro"

web_name = "Web-Tier-ASG"
web_min_size = 2
web_max_size = 4
web_desired_capacity = 2

web_tags = "Web-Instance"

################################
# App Tier Configuration
################################

app_alb_name = "App-Tier-ALB"
app_alb_scheme = true
app_tg_name = "app-tier-target-group"

app_name_prefix = "App-Template"
app_instance_type = "t3.micro"

app_name = "App-Tier-ASG"
app_min_size = 2
app_max_size = 4
app_desired_capacity = 2

app_tags = "App-Tier-Instance"

################################
# Database Configuration
################################

db_password = "your-secure-password"
```

------------------------------------------------------------------------

## Step 5: Validate Terraform Code

``` bash
terraform validate
```

------------------------------------------------------------------------

## Step 6: Select Workspace

``` bash
terraform workspace select <env-name>
```

Example:

``` bash
terraform workspace select Develop
```

------------------------------------------------------------------------

## Step 7: Create Terraform Plan

``` bash
terraform plan \
-var-file=<env-name>.tfvars \
-out=<env-name>_outfile.txt
```

Example:

``` bash
terraform plan \
-var-file=develop.tfvars \
-out=develop_outfile.txt
```

------------------------------------------------------------------------

## Step 8: Deploy Infrastructure

``` bash
terraform apply "<env-name>_outfile.txt"
```

------------------------------------------------------------------------

## Step 9: Refresh Terraform State

``` bash
terraform refresh "<env-name>_outfile.txt"
```

------------------------------------------------------------------------

## Step 10: Save Terraform Outputs

``` bash
terraform output > <env-name>_outputs.txt
```

------------------------------------------------------------------------

## Step 11: Terraform Backend State Storage

    S3 Bucket
     └── env
          ├── Develop
          │    └── terraform.tfstate
          ├── Test
          │    └── terraform.tfstate
          └── Pre-prod
               └── terraform.tfstate

Each workspace maintains **separate state files**.

