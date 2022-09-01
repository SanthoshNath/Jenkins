resource "aws_key_pair" "key" {
  key_name   = "key"
  public_key = file(var.path_to_public_key)
}

resource "aws_instance" "jenkins_instance" {
  ami             = var.instance_ami
  instance_type   = var.instance_type
  key_name        = aws_key_pair.key.key_name
  security_groups = [aws_security_group.jenkins_security_group.name]
  user_data       = templatefile("${path.module}/user_data.tftpl", {})

  tags = {
    Name = "jenkins_instance"
  }
}
