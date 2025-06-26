# resource "aws_lb" "application" {
#     name="prakash-application-loadbalancer"
#     internal = false
#     load_balancer_type = "application"
#     security_groups = [aws_security_group.sg.id]
#     subnets = [aws_subnet.publicsubnets[0].id,aws_subnet.publicsubnets[1].id]
#     tags = {
#       Name="${var.vpc_name}-application"

#     }
  
# }

# resource "aws_lb_target_group" "prakash" {
#     name="prakash-target"
#     port = 80
#     protocol = "HTTP"
#     vpc_id = aws_vpc.chandra.id
#     health_check {
#       interval = 30
#       protocol = "HTTP"
#       path = "/index.html"
#       timeout = 5
#       healthy_threshold = 2
#       unhealthy_threshold = 2

#     }
#  tags = {
#    Name="${var.vpc_name}-prakash-tg"
#  }
  
# }

# resource "aws_lb_listener" "http" {
#     load_balancer_arn = aws_lb.application.arn
#     port = 80
#     protocol = "HTTP"
#     default_action {
#       type = "forward"
#       target_group_arn = aws_lb_target_group.prakash.arn
#     }
  
# }

# resource "aws_lb_target_group_attachment" "instance1" {
#     count = 1
#     target_group_arn = aws_lb_target_group.prakash.arn
#     target_id = element(aws_instance.private_instance.*.id,count.index)
#     port=80

  
# }