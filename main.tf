resource "aws_instance" "jenkins_instance" {
  ami                    = var.instance_ami
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.jenkins_vpc_public_subnet.id
  vpc_security_group_ids = [aws_security_group.jenkins_security_group.id]
  user_data              = templatefile("${path.module}/user_data.tftpl", {})

  tags = {
    Name = "jenkins_instance"
  }
}
