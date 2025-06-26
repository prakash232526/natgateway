resource "aws_instance" "public_instance" {
    count=1
    ami = var.ami
    key_name = var.key_name
    instance_type = var.instance_type
    vpc_security_group_ids =[aws_security_group.sg.id]
    associate_public_ip_address = true
    subnet_id = element(aws_subnet.publicsubnets.*.id,count.index)
    private_ip =element(var.private_ip,count.index)
    iam_instance_profile = var.profile
    user_data = <<-EOF
   #!/bin/bash
    yum update -y 
    yum install wget -y
    wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo
    rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
    yum upgrade -y
    yum install java-17-amazon-corretto-headless -y
    yum install jenkins -y
    systemctl start jenkins
    systemctl daemon-reload
    EOF
    tags = {
      Name="${var.vpc_name}-public_server${count.index+1}"
    
    }



}

resource "aws_instance" "private_instance" {
    count=1
    ami = var.ami
    key_name = var.key_name
    instance_type = var.instance_type
    vpc_security_group_ids =[aws_security_group.sg.id]
    subnet_id = element(aws_subnet.privatesubnets.*.id,count.index)
    private_ip =element(var.private_ips,count.index)
    iam_instance_profile = var.profile
    user_data = <<-EOF
   #!/bin/bash
    yum update -y
    yum install wget -y
    wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo
    rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
    yum upgrade -y
    yum install java-17-amazon-corretto-headless -y
    yum install jenkins -y
    systemctl start jenkins
    systemctl daemon-reload
    EOF
    tags = {
      Name="${var.vpc_name}-private_server${count.index+1}"
    
    }



}

