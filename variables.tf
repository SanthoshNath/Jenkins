variable "aws_region" {
  type     = string
  nullable = false
}

variable "path_to_public_key" {
  type      = string
  nullable  = false
  sensitive = true
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

variable "enable_ec2_instance_connect" {
  default  = true
  type     = bool
  nullable = false
}

variable "jenkins_port" {
  default  = 8080
  type     = number
  nullable = false
}

variable "expose_jenkins_url" {
  default  = true
  type     = bool
  nullable = false
}

variable "ingress_cidr_blocks_for_jenkins_port" {
  default  = ["0.0.0.0/0"]
  type     = list(string)
  nullable = false
}
