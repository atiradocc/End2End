terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

variable "aws_profile" {
	type = string
	sensitive = true
}

variable "user_key" {
	type = string
	sensitive = true
}

provider "aws" {
	region = "us-west-2"
	profile = var.aws_profile
}

resource "aws_security_group" "simpleEC2-sg-tf" {
	name = "simpleEC2-sg-tf"
	description = "SG for simpleEC2-sg-tf"

	ingress = [
		{
			description = "allow ssh in"
			protocol = "tcp"
			from_port = 22
			to_port = 22
			cidr_blocks = ["0.0.0.0/0"]
			ipv6_cidr_blocks = ["::/0"]
			self = false
			security_groups = []
			prefix_list_ids = []
		}
	]

	egress = [
		{
			description = "allow going anywhere"
			protocol = "tcp"
			from_port = 0
			to_port = 0
			cidr_blocks = ["0.0.0.0/0"]
			ipv6_cidr_blocks = ["::/0"]
			self = false
			security_groups = []
			prefix_list_ids = []
		}
	]
}

resource "aws_instance" "simpleEC2-tf" {
	ami = "ami-0a12b6f54cdcb8114"
	key_name = var.user_key
	instance_type = "c6g.medium"

	security_groups = ["simpleEC2-sg-tf"]
}
