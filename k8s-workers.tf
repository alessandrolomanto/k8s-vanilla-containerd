# Create EC2 Instance 
resource "aws_instance" "kubernetes-node" {
  count         = var.worker_count
  ami           = data.aws_ami.amzlinux.id
  instance_type = var.ec2_instance_type
  subnet_id     = aws_subnet.vpc-kubernetes-public-subnet-1.id
  key_name      = var.key_name
  vpc_security_group_ids = [aws_security_group.vpc-ssh.id, aws_security_group.vpc-kubernetes-api.id]

  depends_on = [aws_instance.kubernetes-master]
  tags = {
    "Name" = "${var.cluster_name}-node-${count.index}"
  }

  connection {
    type = "ssh"
    host = self.public_ip # Understand what is "self"
    user = "ubuntu"
    password = ""
    private_key = file("${var.key_name}.pem")
  }  

    provisioner "file" {
    source      = "provision/terraform/main.sh"
    destination = "/home/ubuntu/main.sh"
  }

  provisioner "file" {
    source      = "joincluster.sh"
    destination = "/home/ubuntu/joincluster.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo bash /home/ubuntu/main.sh",
      "sleep 10", 
      "sudo bash /home/ubuntu/joincluster.sh"
    ]
  }


}



