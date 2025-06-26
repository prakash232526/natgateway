resource "aws_lb" "network" {
    name="network-lb"
    internal = false
    load_balancer_type = "network"
    subnets = [aws_subnet.publicsubnets[0].id,aws_subnet.publicsubnets[1].id]
    tags = {
      Name="${var.vpc_name}-nlb"
    }
  
}

resource "aws_lb_target_group" "nlb-target" {
    name="nlb-target"
    vpc_id = aws_vpc.chandra.id
    protocol = "TCP"
    port="8080"
    health_check {
      interval = 30
      healthy_threshold = 2
      unhealthy_threshold = 2
      timeout = 5
      protocol = "TCP"

    }
    tags={
        Name="${var.vpc_name}-target"

    }
}

resource "aws_lb_listener" "nlb-listner" {
    load_balancer_arn = aws_lb.network.arn
    protocol = "TCP"
    port=80
    default_action {
      type = "forward"
      target_group_arn = aws_lb_target_group.nlb-target.arn
    }

  
}

resource "aws_lb_target_group_attachment" "private-servers" {
    count = 1
    target_group_arn = aws_lb_target_group.nlb-target.arn
    target_id = element(aws_instance.private_instance.*.id,count.index)
    port = 8080
  
}