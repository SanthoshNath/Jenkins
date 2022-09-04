resource "aws_key_pair" "key" {
  key_name   = "key"
  public_key = file(var.path_to_public_key)
}

resource "aws_instance" "jenkins_instance" {
  ami                    = var.instance_ami
  instance_type          = var.instance_type
  key_name               = aws_key_pair.key.key_name
  subnet_id              = aws_subnet.jenkins_vpc_public_subnet.id
  vpc_security_group_ids = [aws_security_group.jenkins_security_group.id]
  user_data              = templatefile("${path.module}/user_data.tftpl", {})

  tags = {
    Name = "jenkins_instance"
  }
}
