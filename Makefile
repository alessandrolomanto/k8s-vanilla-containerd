vagrant-start:
	vagrant up

vagrant-destroy:
	vagrant destroy -f

init:
	terraform init

apply:
	terraform plan -out terraform.plan
	terraform apply terraform.plan

destroy:
	./clean.sh

output:
	terraform output -raw get_kubeconfig > download_kubeconfig.sh
	bash download_kubeconfig.sh
