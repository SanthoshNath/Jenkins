locals {
  policy_arn = sensitive("arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore")
  assume_role_policy = sensitive(jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "ec2.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    }
  ))
}

resource "aws_instance" "jenkins_instance" {
  ami                    = var.instance_ami
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.jenkins_vpc_public_subnet.id
  vpc_security_group_ids = [aws_security_group.jenkins_security_group.id]
  user_data              = templatefile("${path.module}/user_data.tftpl", {})
  iam_instance_profile   = aws_iam_instance_profile.jenkins_iam_instance_profile.name

  root_block_device {
    encrypted = true
  }

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  tags = {
    Name = "jenkins_instance"
  }
}

resource "aws_iam_instance_profile" "jenkins_iam_instance_profile" {
  name = "jenkins-iam-instance-profile"
  role = aws_iam_role.jenkins_iam_role.name
}

resource "aws_iam_role" "jenkins_iam_role" {
  name               = "jenkins-iam-role"
  assume_role_policy = local.assume_role_policy
}

resource "aws_iam_role_policy_attachment" "jenkins_ssm_policy" {
  role       = aws_iam_role.jenkins_iam_role.name
  policy_arn = local.policy_arn
}
