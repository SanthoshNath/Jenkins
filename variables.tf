variable "aws_region" {
  type     = string
  nullable = false
}

variable "vpc_cidr_block" {
  type     = string
  nullable = false
}

variable "public_subnets_count" {
  default  = 2
  type     = number
  nullable = false

  validation {
    condition     = var.public_subnets_count % 1 == 0
    error_message = "Number of public subnets should be a whole number"
  }

  validation {
    condition     = var.public_subnets_count > 1
    error_message = "Minimum of two public subnets are required"
  }
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

variable "jenkins_port" {
  default  = 8080
  type     = number
  nullable = false

  validation {
    condition     = var.jenkins_port % 1 == 0
    error_message = "Port number should be a whole number"
  }
}

variable "ingress_cidr_blocks_for_jenkins_port" {
  default  = ["0.0.0.0/0"]
  type     = list(string)
  nullable = false
}
