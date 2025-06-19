resource "aws_subnet" "publicsubnets" {
    count = 3
    vpc_id = aws_vpc.chandra.id
    cidr_block = element(var.cidr_block_publicsubnets,count.index)
    availability_zone = element(var.azs,count.index)
    map_public_ip_on_launch = true
    tags = {
        Name = "${var.vpc_name}-publicsubnets${count.index+1}"
    }
  
}

resource "aws_subnet" "privatesubnets" {
    count = 3
    vpc_id = aws_vpc.chandra.id
    cidr_block = element(var.cidr_block_privatesubnets,count.index)
    availability_zone = element(var.azs,count.index)
    tags = {
        Name = "${var.vpc_name}-privatesubnets${count.index+1}"
    }
  
}