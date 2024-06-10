resource "aws_instance" "cicd_webserver" {
  ami           = var.ami
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.cicd_sg.id]
  subnet_id = aws_subnet.public_cicd.id

  user_data = <<-EOF
  #!/bin/bash
  echo "*** Installing apache2"
  sudo apt update -y
  sudo apt install apache2 -y
  echo "*** Completed Installing apache2"
  EOF
}

resource "aws_security_group" "cicd_sg" {
  name        = "demo_sg"  # Security group
  description = "Allow TLS inbound traffic and all outbound traffic"  # Description of the security group
  vpc_id      = aws_vpc.cicd_vpc.id  # Associate the security group with the specified VPC

  ingress {
    from_port       =  80  # Port to allow inbound traffic from
    to_port         = 80  # Port to allow inbound traffic to
    protocol        = "tcp"  # Protocol for inbound traffic
    self            = true  # Allow traffic from the security group itself
    cidr_blocks     = ["0.0.0.0/0"]  # Allow inbound traffic from any IP address
  }

  egress {
    from_port       =  80  # Port to allow outbound traffic from
    to_port         = 80  # Port to allow outbound traffic to
    protocol        = "tcp"  # Protocol for outbound traffic
    self            = true  # Allow outbound traffic to the security group itself
    cidr_blocks     = ["0.0.0.0/0"]  # Allow outbound traffic to any IP address
  }
}

resource "aws_vpc" "cicd_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "public_cicd" {
  vpc_id     = aws_vpc.cicd_vpc.id
  cidr_block = "10.0.1.0/24"
}

  resource "aws_subnet" "private_cicd" {
  vpc_id     = aws_vpc.cicd_vpc.id
  cidr_block = "10.0.2.0/24"
}

resource "aws_internet_gateway" "demo_igw" {
  vpc_id = aws_vpc.cicd_vpc.id
}

resource "aws_route_table" "demo_rt" {
  vpc_id = aws_vpc.cicd_vpc.id

  route {
    cidr_block = "10.0.0.0/24"
    gateway_id = aws_internet_gateway.demo_igw.id
 }
}

resource "aws_s3_bucket" "cicd24-s3-bucket" {
  bucket = "my-tf-demo-bucket"
}