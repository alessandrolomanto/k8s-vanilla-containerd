# Terraform Destroy
terraform destroy -auto-approve

# Delete Terraform files 
rm -rf .terraform*
rm -rf terraform.tfstate*
rm -rf terraform.plan
rm -rf joincluster.sh download_kubeconfig.sh