resource "aws_eip" "eips" {
    tags = {
        Name = "${var.vpc_name}-eip"
    }

  
}

resource "aws_nat_gateway" "ngw" {
    allocation_id = aws_eip.eips.id
    subnet_id = aws_subnet.publicsubnets.0.id
    tags = {
        Name = "${var.vpc_name}-ngw"
    }
  depends_on = [aws_internet_gateway.igw]
}