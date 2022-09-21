output "jenkins_url" {
  value = "http://${aws_lb.jenkins_lb.dns_name}"
}
