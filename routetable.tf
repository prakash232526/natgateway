resource "aws_route_table" "publicrt" {
    vpc_id = aws_vpc.chandra.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
  tags = {
    Name = "${var.vpc_name}-publicrt"
  }
}

resource "aws_route_table" "privatert" {
    vpc_id = aws_vpc.chandra.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.ngw.id
    }
    tags = { 
        Name = "${var.vpc_name}-privatrt"
    }
  
}

resource "aws_route_table_association" "publicassociate" {
    count = 3
    route_table_id = aws_route_table.publicrt.id
    subnet_id = element(aws_subnet.publicsubnets.*.id,count.index)

  
}

resource "aws_route_table_association" "privateassociation" {
    count = 3
    route_table_id = aws_route_table.privatert.id
    subnet_id = element(aws_subnet.privatesubnets.*.id,count.index)
  
}