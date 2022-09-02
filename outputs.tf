output "jenkins_url" {
  value = "http://${aws_instance.jenkins_instance.public_dns}:${var.jenkins_port}"
}
