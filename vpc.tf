locals {
  subnet_bits              = ceil(log(var.public_subnets_count, 2))
  cidr_subnets             = [for net in range(0, var.public_subnets_count) : cidrsubnet(var.vpc_cidr_block, local.subnet_bits, net)]
  availability_zones_count = length(data.aws_availability_zones.available.names)
}

resource "aws_vpc" "jenkins" {
  cidr_block           = var.vpc_cidr_block
  instance_tenancy     = "default"
  enable_dns_hostnames = "true"

  tags = {
    Name = "jenkins_vpc"
  }
}

resource "aws_subnet" "jenkins_public" {
  count = length(local.cidr_subnets)

  vpc_id                  = aws_vpc.jenkins.id
  cidr_block              = local.cidr_subnets[count.index]
  map_public_ip_on_launch = "true"
  availability_zone       = count.index < local.availability_zones_count ? data.aws_availability_zones.available.names[count.index] : data.aws_availability_zones.available.names[count.index % local.availability_zones_count]

  tags = {
    Name = "jenkins_public_subnet_${count.index + 1}"
  }
}

resource "aws_internet_gateway" "jenkins" {
  vpc_id = aws_vpc.jenkins.id

  tags = {
    Name = "jenkins_internet_gateway"
  }
}

resource "aws_route_table" "jenkins" {
  vpc_id = aws_vpc.jenkins.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.jenkins.id
  }

  tags = {
    Name = "jenkins_route_table"
  }
}

resource "aws_route_table_association" "jenkins_public" {
  count = length(local.cidr_subnets)

  subnet_id      = aws_subnet.jenkins_public[count.index].id
  route_table_id = aws_route_table.jenkins.id
}
