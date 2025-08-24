terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = ">= 1.0.0"
}

provider "aws" {
  region     = var.AWS_REGION
  access_key = "${secrets.AWS_ACCESS_KEY}"
  secret_key = "${secrets.AWS_SECRET_KEY}"
}