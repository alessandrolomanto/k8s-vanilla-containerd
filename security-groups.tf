# Create Security Group - SSH Traffic

# locals {
#   ports = [80, 443, 8080, 8081, 7080, 7081]
# }

# # Create Security Group using Terraform Dynamic Block
# resource "aws_security_group" "sg-dynamic" {
#   name        = "dynamic-block-demo"
#   description = "dynamic-block-demo"

#   dynamic "ingress" {
#     for_each = local.ports
#     content {
#       description = "description ${ingress.key}"
#       from_port   = ingress.value
#       to_port     = ingress.value
#       protocol    = "tcp"
#       cidr_blocks = ["0.0.0.0/0"]
#     }
#   }
# }

resource "aws_security_group" "vpc-ssh" {
  name        = "vpc-ssh"
  description = "Dev VPC SSH"
  vpc_id      = aws_vpc.vpc-kubernetes.id
  ingress {
    description = "Allow Port 22"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "Allow all ip and ports outboun"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "vpc-kubernetes-api" {
  name        = "vpc-kubernetes-api"
  description = "Kubernetes VPC API"
  vpc_id      = aws_vpc.vpc-kubernetes.id
  ingress {
    description = "Allow Port 6443"
    from_port   = 6443
    to_port     = 6443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all ip and ports outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}