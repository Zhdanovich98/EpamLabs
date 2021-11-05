terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = "us-east-2"
}

resource "aws_launch_template" "foobar" {
  name_prefix            = "foobar"
  image_id               = "ami-0629230e074c580f2"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.ssh-allowed.id]
  key_name               = aws_key_pair.terraform-keys2.key_name
  user_data              = filebase64("./nginx.sh")

  block_device_mappings {
    device_name = "/dev/sda1"

    ebs {
      volume_size = 8
    }
  }
}

resource "aws_key_pair" "terraform-keys2" {
  key_name   = "terraform-keys2"
  public_key = file("./terraform-keys2.pub")
}

resource "aws_autoscaling_group" "bar" {
  vpc_zone_identifier  = [aws_subnet.prod-subnet-public-1.id]
  termination_policies = ["OldestInstance"]
  desired_capacity     = 2
  max_size             = 3
  min_size             = 2


  launch_template {
    id      = aws_launch_template.foobar.id
    version = "$Latest"
  }

}

resource "aws_autoscaling_attachment" "asg_attachment_bar" {
  autoscaling_group_name = aws_autoscaling_group.bar.id
  alb_target_group_arn   = aws_lb_target_group.lb_target_group.arn
}


resource "aws_eip" "eip_nlb" {
  tags = {
    Name = "network-lb-eip"
    Env  = "lb-eip"
  }
}


resource "aws_vpc" "prod-vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = "true" #gives you an internal domain name
  enable_dns_hostnames = "true" #gives you an internal host name
  enable_classiclink   = "false"
  instance_tenancy     = "default"

  tags = {
    Name = "prod-vpc"
  }
}
/*
resource "aws_vpc_endpoint_service" "example" {
  acceptance_required        = false
  network_load_balancer_arns = [aws_lb.network_lb.arn]
}

resource "aws_vpc_endpoint" "example1" {
  service_name       = aws_vpc_endpoint_service.example.service_name
  subnet_ids         = [aws_subnet.prod-subnet-public-1.id]
  vpc_endpoint_type  = aws_vpc_endpoint_service.example.service_type
  vpc_id             = aws_vpc.prod-vpc.id
  security_group_ids = [aws_security_group.ssh-allowed.id]
}
*/
resource "aws_subnet" "prod-subnet-public-1" {
  vpc_id                  = aws_vpc.prod-vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "true" //it makes this a public subnet
  availability_zone       = "us-east-2a"
  tags = {
    Name = "prod-subnet-public-1"
  }
}

resource "aws_internet_gateway" "prod-igw" {
  vpc_id = aws_vpc.prod-vpc.id
  tags = {
    Name = "prod-igw"
  }
}

resource "aws_route_table" "prod-public-crt" {
  vpc_id = aws_vpc.prod-vpc.id

  route {
    //associated subnet can reach everywhere
    cidr_block = "0.0.0.0/0"
    //CRT uses this IGW to reach internet
    gateway_id = aws_internet_gateway.prod-igw.id
  }

  tags = {
    Name = "prod-public-crt"
  }
}

resource "aws_route_table_association" "prod-crta-public-subnet-1" {
  subnet_id      = aws_subnet.prod-subnet-public-1.id
  route_table_id = aws_route_table.prod-public-crt.id
}

output "public_ip_lb" {
  value = aws_eip.eip_nlb.public_ip
}

output "dns_name" {
  value = aws_lb.network_lb.dns_name
}
