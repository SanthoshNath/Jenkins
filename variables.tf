variable "aws_region" {
  type     = string
  nullable = false
}

variable "vpc_cidr_block" {
  type     = string
  nullable = false
}

variable "instance_ami" {
  default  = "ami-06489866022e12a14"
  type     = string
  nullable = false
}

variable "instance_type" {
  default  = "t2.micro"
  type     = string
  nullable = false
}
