module "ec2" {
  source = "github.com/SanthoshNath/EC2?ref=v1.1"

  vpc_cidr_block       = var.vpc_cidr_block
  instance_ami         = var.instance_ami
  instance_type        = var.instance_type
  user_data_path       = "${path.root}/user_data.tftpl"
  port                 = 8080
  name_prefix          = "jenkins"
  enable_load_balancer = true
}
