provider "aws" {
   region = "eu-north-1"
}

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "Netology-with-module"

  ami                    = "ami-ebd02392"
  instance_type          = "t3.micro"
}