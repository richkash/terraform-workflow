variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}

variable "AWS_REGION" {
  description = "AWS Region"
  type        = string
  default     = "us-east-1"
}

variable "AMI" {
  description = "value"
  type        = string
  default     = "ami-0bbdd8c17ed981ef9" # Ubuntu Server 24.04 LTS
}

variable "public_subnets" {
  description = "List of public subnet CIDR blocks."
  default = [
    { name = "public-subnet-1", cidr_block = "10.0.1.0/24", az = "us-east-1a" },
    { name = "public-subnet-2", cidr_block = "10.0.2.0/24", az = "us-east-1b" }
  ]
}

variable "private_subnets" {
  description = "List of private subnet CIDR blocks."
  default = [
    { name = "private-subnet-1", cidr_block = "10.0.101.0/24", az = "us-east-1a" },
    { name = "private-subnet-2", cidr_block = "10.0.102.0/24", az = "us-east-1b" }
  ]
}