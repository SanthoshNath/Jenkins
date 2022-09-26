resource "aws_lb" "jenkins" {
  name                             = "jenkins-lb"
  internal                         = false
  load_balancer_type               = "application"
  subnets                          = [for subnet in aws_subnet.jenkins_public : subnet.id]
  security_groups                  = [aws_security_group.jenkins_lb.id]
  enable_cross_zone_load_balancing = true
  drop_invalid_header_fields       = true

  tags = {
    Name = "jenkins_lb"
  }
}

resource "aws_lb_target_group" "jenkins" {
  name     = "jenkins-lb-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.jenkins.id
}

resource "aws_lb_target_group_attachment" "jenkins" {
  target_group_arn = aws_lb_target_group.jenkins.arn
  target_id        = aws_instance.jenkins.id
  port             = var.jenkins_port
}

resource "aws_lb_listener" "jenkins" {
  load_balancer_arn = aws_lb.jenkins.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "forward"

    forward {
      target_group {
        arn = aws_lb_target_group.jenkins.arn
      }

      stickiness {
        duration = 1
      }
    }
  }
}

resource "aws_security_group" "jenkins_lb" {
  name   = "jenkins-lb-security-group"
  vpc_id = aws_vpc.jenkins.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.ingress_cidr_blocks_for_jenkins_port
  }

  tags = {
    Name = "jenkins_lb_security_group"
  }
}
