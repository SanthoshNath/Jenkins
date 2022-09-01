resource "aws_security_group" "jenkins_security_group" {
  name = "Jenkins security group"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [local.myIP]
  }

  ingress {
    from_port   = var.jenkins_port
    to_port     = var.jenkins_port
    protocol    = "tcp"
    cidr_blocks = var.ingress_cidr_blocks_for_jenkins_port
  }

  tags = {
    Name = "jenkins_security_group"
  }
}
