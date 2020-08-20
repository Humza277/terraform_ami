# Launch a ami on aws
# waht do we want to do and where do we want to create instance
# terraform syntax - simmilar to JSON 
provider "aws" {
#which region do we have the ami available in
  region = "eu-west-1"
}
# create from ami image
resource "aws_instance" "app_instance" {ami = "ami-01561b0b028f2d8de"
#what type of instance we want to create
          instance_type = "t2.micro"
# do we want public ip 
	  associate_public_ip_address = true
          tags {Name = "eng67.humza.terraform.web}
}
