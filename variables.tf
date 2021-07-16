# Input Variables
variable "aws_region" {
  description = "Region in which AWS Resources to be created"
  type = string
  default = "eu-west-1"
}

variable "ec2_instance_type" {
  description = "EC2 Instance Type"
  type = string
  default = "t2.medium"
}

variable "key_name" {
  description = "Name SSH Key"
  type = string
  default = "terraform-key"
}

variable cluster_name {
  type        = string
  description = "Cluster name"
  default = "kubernetes"
}


variable "worker_count" {
  description = "Number of kubernetes master node"
  type = string
  default = 1
}



