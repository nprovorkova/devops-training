# Configure the AWS Provider
provider "aws" {
  region = "eu-north-1"
}

terraform {
  backend "s3" {
    bucket = "netology-state-dev"
    key    = "bucket-key-path"
    region = "eu-north-1"
  }
}
/*Этот блок нужен для того, чтобы читать стейты другого проекта, то есть в данном случае не нужен:
data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = "netology-state-dev"
    key    = format( "env:/%s/bucket-key-path", terraform.workspace)
    region = "eu-north-1"
  }
}*/

data "aws_ami" "ubuntu" {
    most_recent = true

     filter {
        name   = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
    }

    filter {
        name = "virtualization-type"
        values = ["hvm"]
    }

    owners = ["099720109477"] # Canonical
}

locals {
  web_instance_type_map = {
    stage = "t3.micro"
    prod = "t3.large"
  }
  web_instance_count_map = {
    stage = 1
    prod = 2
  }
  instances = terraform.workspace == "prod" ? toset(["0", "1"]) : toset(["0"])
}

resource "aws_instance" "first_aws_instance" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = local.web_instance_type_map[terraform.workspace]
  count         = local.web_instance_count_map[terraform.workspace]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_instance" "second_aws_instance" {
  for_each      = local.instances

  ami           = data.aws_ami.ubuntu.id
  //?? Надо брать из each.key и  each.value, а не из local.web_instance_type_map[terraform.workspace], но не понятно как
  instance_type = local.web_instance_type_map[terraform.workspace]
}

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}