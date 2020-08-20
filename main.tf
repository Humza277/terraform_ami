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
  vpc_security_group_ids = ["${aws_security_group.ami_sec_group.id}"]
  tags = {
    Name = "eng67.humza.terraform.web"
  }
}
resource "aws_subnet" "public_ip" {

  cidr_block = "172.31.100.0/24"
  vpc_id = var.vpc_id
}

resource "aws_security_group" "ami_sec_group" {
  name = "ami_sec_group"
  description = "allow traffic in"
  vpc_id = var.vpc_id

  ingress {
    description = "allow inbound traffic"
    from_port = 80
    protocol = "tcp"
    to_port = 80
    cidr_blocks = ["172.31.0.0/16"]
  }
  egress {
    from_port = 0
    protocol = -1
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "ami.humza"
  }
}
