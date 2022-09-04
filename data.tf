data "aws_availability_zones" "current_availability_zones" {
  state = "available"
}

data "aws_ip_ranges" "ec2_connect_ip_ranges" {
  count    = var.enable_ec2_instance_connect ? 1 : 0
  regions  = [var.aws_region]
  services = ["ec2_instance_connect"]
}

data "http" "my_IP" {
  url = "https://ipv4.icanhazip.com"
}
