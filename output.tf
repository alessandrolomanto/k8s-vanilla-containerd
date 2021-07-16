
output "ssh_master" {
  value = <<EOT
  ssh -i ${var.key_name}.pem ubuntu@${aws_instance.kubernetes-master.public_ip}
  EOT
}

output "get_kubeconfig" {
  description = "Get kubeconfig"
  value = <<EOT
  ssh -i terraform-key.pem ubuntu@${aws_instance.kubernetes-master.public_ip} "sudo cat /etc/kubernetes/admin.conf" | sed 's/${aws_instance.kubernetes-master.private_ip}/${aws_instance.kubernetes-master.public_ip}/g' > ~/.kube/${var.cluster_name}
  echo "To enable KUBECONFIG: export KUBECONFIG=~/.kube/${var.cluster_name}"
  EOT
}


