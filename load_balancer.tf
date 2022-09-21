resource "aws_lb" "jenkins_lb" {
  name                             = "jenkins-lb"
  internal                         = false
  load_balancer_type               = "application"
  subnets                          = [for subnet in aws_subnet.jenkins_public_subnet : subnet.id]
  security_groups                  = [aws_security_group.jenkins_lb_security_group.id]
  enable_cross_zone_load_balancing = true
  drop_invalid_header_fields       = true

  tags = {
    Name = "jenkins_lb"
  }
}

resource "aws_lb_target_group" "jenkins_lb_target_group" {
  name     = "jenkins-lb-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.jenkins_vpc.id
}

resource "aws_lb_target_group_attachment" "jenkins_lb_target_group_attachment" {
  target_group_arn = aws_lb_target_group.jenkins_lb_target_group.arn
  target_id        = aws_instance.jenkins_instance.id
  port             = var.jenkins_port
}

resource "aws_lb_listener" "jenkins_lb_listener" {
  load_balancer_arn = aws_lb.jenkins_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "forward"

    forward {
      target_group {
        arn = aws_lb_target_group.jenkins_lb_target_group.arn
      }

      stickiness {
        duration = 1
      }
    }
  }
}

resource "aws_security_group" "jenkins_lb_security_group" {
  name   = "jenkins-lb-security-group"
  vpc_id = aws_vpc.jenkins_vpc.id

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
