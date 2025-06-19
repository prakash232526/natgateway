resource "aws_vpc" "chandra" {
    cidr_block = var.cidr_block  
    enable_dns_hostnames = true
    tags = {
        Name = "${var.vpc_name}"
    }
}


resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.chandra.id
    tags = {
        Name = "${var.vpc_name}-igw"
    }
  
}

