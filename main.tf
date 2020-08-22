# Launch a ami on aws
# what do we want to do and where do we want to create instance
# terraform syntax - similar to JSON
provider "aws" {
#which region do we have the ami available in
  region = "eu-west-1"
}


# create from ami image
resource "aws_instance" "app_instance" {
  ami = "ami-01561b0b028f2d8de"

  #what type of instance we want to create
  instance_type = "t2.micro"
  # do we want public ip
  associate_public_ip_address = true
  vpc_security_group_ids = [
    aws_security_group.ami_sec_group.id]
  tags = {
    Name = "Eng67.Humza.Terraform.Web"
  }
}



# create vpc
resource "aws_vpc" "terra_vpc" {
  cidr_block       = "200.160.0.0/16"
  enable_dns_support = "true" #gives you an internal domain name
  enable_dns_hostnames = "true" #gives you an internal host name
  enable_classiclink = "false"
  instance_tenancy = "default"

  tags = {
    Name = "Eng67.Humza.Terraform.VPC"
  }
}




#create internet gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.terra_vpc.id

  tags = {
    Name = "Eng67.Humza.Terraform.Internet.Gateway"
  }
}




# public subnet
resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.terra_vpc.id
  cidr_block = "200.160.5.0/24"

  tags = {
    Name = "Eng67.Humza.Terraform.PublicSubnet"
  }
}


#Private subnet
resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.terra_vpc.id
  cidr_block = "200.160.10.0/24"

  tags = {
    Name = "Eng67.Humza.Terraform.PublicSubnet"
  }
}



# creating public route table
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.terra_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "Eng67.Humza.Terraform.Public.Route.Table"
  }
}



# assigning public subnet to public route table
resource "aws_route_table_association" "public-association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}



# setting up instance security group
resource "aws_security_group" "ami_sec_group" {
  name = "ami_sec_group"
  description = "allow traffic in"
  vpc_id = var.vpc_id

  ingress {
    description = "allow inbound traffic"
    from_port = 80
    protocol = "tcp"
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "allow inbound traffic"
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = ["86.4.83.36/32"]
  }

  egress {
    from_port = 0
    protocol = -1
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "Eng67.Humza.Terraform.PublicSubnet"
  }
}
