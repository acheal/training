
# DO NOT DELETE THESE LINES!
#
# Your AMI ID is:
#
#     ami-4809fd31
#
# Your subnet ID is:
#
#     subnet-1db13054
#
# Your security group ID is:
#
#     sg-b2a021ca
#
# Your Identity is:
#
#     Idol-training-mule

#export ATLAS_TOKEN="LvNDeDajOr8tzg.atlasv1.zLdhfeczhRyE5HEvekgnBeJ3SEz4yd15mix4p9IQMS70oOJnUy7QayyQqkwk79wuXp0"

terraform {
  backend "atlas" {
    name    = "acheal/training"
#    address = ""
  }
}

variable "aws_access_key" {}

variable "aws_secret_key" {}

variable "aws_region" {
  default = "eu-west-1"
}

provider "aws" {


  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"

  region = "${var.aws_region}"
}

resource "aws_instance" "web" {
  ami                    = "ami-4809fd31"
  instance_type          = "t2.micro"
  subnet_id              = "subnet-1db13054"
  vpc_security_group_ids = ["sg-b2a021ca"]
  count                  = "2"

  tags {
    "Identity" = "Idol-training-mule"
    "name"     = "Andrew Cheal"
    "company"  = "theidol.com"
    "index"    = "${count.index}"
  }
}

output "public_ip" {
  value = "${aws_instance.web.*.public_ip}"
}

output "public_dns" {
  value = "${aws_instance.web.*.public_dns}"
}
