output "jenkins_url" {
  value = "http://${module.ec2.alb_dns}"
}
