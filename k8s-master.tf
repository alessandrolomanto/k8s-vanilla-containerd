# Create EC2 Instance 
resource "aws_instance" "kubernetes-master" {

  ami           = data.aws_ami.amzlinux.id
  instance_type = var.ec2_instance_type
  subnet_id     = aws_subnet.vpc-kubernetes-public-subnet-1.id
  key_name      = var.key_name
  vpc_security_group_ids = [aws_security_group.vpc-ssh.id, aws_security_group.vpc-kubernetes-api.id]
  tags = {
    "Name" = "${var.cluster_name}-master"
  }

    # Connection Block for Provisioners to connect to EC2 Instance
  connection {
    type = "ssh"
    host = self.public_ip 
    user = "ubuntu"
    password = ""
    private_key = file("${var.key_name}.pem")
  }  

  provisioner "file" {
    source      = "provision/terraform/main.sh"
    destination = "/home/ubuntu/main.sh"
  }

  provisioner "file" {
    source      = "provision/terraform/master.sh"
    destination = "/home/ubuntu/master.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo bash /home/ubuntu/main.sh",
      "sleep 10", 
      "sudo bash /home/ubuntu/master.sh"
    ]
  }

  provisioner "local-exec" {
  command = "scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i ${var.key_name}.pem ubuntu@${self.public_ip}:~/joincluster.sh ."
}


}

# module "ec2_cluster" {
#   source                 = "terraform-aws-modules/ec2-instance/aws"
#   version                = "~> 2.0"

#   name                   = "${var.cluster_name}-master"
#   instance_count         = 1

#   ami                    = data.aws_ami.amzlinux.id 
#   instance_type          = var.ec2_instance_type
#   key_name               = var.key_name
#   vpc_security_group_ids = [aws_security_group.vpc-ssh.id, aws_security_group.vpc-kubernetes-api.id] # Get Default VPC Security Group ID and replace
#   subnet_id              = aws_subnet.vpc-kubernetes-public-subnet-1.id # Get one public subnet id from default vpc and replace
#   user_data              = file("provision/main.sh") 
  
#   tags = {
#     "Name" = "${var.cluster_name}-master"
#   }
# }




