terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.16.2"

    }
  }
}

provider "aws" {
  region = "us-east-1"

  # Configuration options
}

variable "ami" {
  default = "ami-04cb4ca688797756f"
}


variable "ssh_pub"{
    default = "~/.ssh/id_rsa.pub"
}


variable "private-key" {
    default = "~/.ssh/id_rsa"

}




resource "aws_instance" "server" {
  ami           = var.ami
  instance_type = "t2.micro"
//  key_name      = aws_instance.provisioner-ec2.public_ip
 key_name = aws_key_pair.ansible-key.key_name


   tags = {
          Name = "Ansible-EC2"
    }
}
