terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 6.36.0"
    }
  }
  backend "s3" {
    bucket = "3-tier-project-rgsmadhav-bucket"
    key = "project-3-tier-aws/terraform.tfstate"
    region = "ap-south-1"
 }
}
