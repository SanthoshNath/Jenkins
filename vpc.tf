resource "aws_vpc" "jenkins_vpc" {
  cidr_block           = "10.0.0.0/28"
  instance_tenancy     = "default"
  enable_dns_hostnames = "true"

  tags = {
    Name = "jenkins_vpc"
  }
}

resource "aws_subnet" "jenkins_vpc_public_subnet" {
  vpc_id                  = aws_vpc.jenkins_vpc.id
  cidr_block              = "10.0.0.0/28"
  map_public_ip_on_launch = "true"
  availability_zone       = data.aws_availability_zones.current_availability_zones.names[0]

  tags = {
    Name = "jenkins_vpc_public_subnet"
  }
}

resource "aws_internet_gateway" "jenkins_internet_gateway" {
  vpc_id = aws_vpc.jenkins_vpc.id

  tags = {
    Name = "jenkins_internet_gateway"
  }
}

resource "aws_route_table" "jenkins_vpc_route_table" {
  vpc_id = aws_vpc.jenkins_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.jenkins_internet_gateway.id
  }

  tags = {
    Name = "main-public-1"
  }
}

resource "aws_route_table_association" "jenkins_vpc_route_association" {
  subnet_id      = aws_subnet.jenkins_vpc_public_subnet.id
  route_table_id = aws_route_table.jenkins_vpc_route_table.id
}
