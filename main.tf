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
  // key_name      = "terrafrom-key"
  key_name = aws_key_pair.ansible-key.key_name


   provisioner "local-exec" {
      working_dir = "/home/ubuntu"
      command = "ansible-playbook --inventory ${self.public_ip}, --private-key ${var.private-key} --user ec2-user play2.yaml"

//    command = "echo the ip address is ${self.public_ip} > output.txt"
  }

   tags = {
          Name = "Ansible-EC2"
    }

}

/* resource "null_resource" "ansible-exec" {

     provisioner "local-exec"
     working_dir = "/home/ubuntu"
      command = "ansible-playbook --inventory ${aws_instance.server-ec2.public_ip}, --private-key ${var.private-key} --user ec2-user play2.yaml"
}*/


resource "aws_key_pair" "ansible-key" {
  key_name = "ansible"
  public_key = file(var.ssh_pub)

}
