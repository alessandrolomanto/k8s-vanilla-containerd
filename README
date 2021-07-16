# Kubernetes without Docker
___

|                     Guide                      |  Environment  | Kubernetes Version |
|:----------------------------------------------:|:-------------:|:------------------:|
|               Kubernetes on AWS                |     ☁ AWS      |       v1.21        | 
|              Kubernetes on Vagrant             | 💻 Local |     v1.21  | 

- ## Kubernetes on AWS
___
### Prerequisites

⚠️ - AWS **charges you** to provision the resources used in this tutorial. You should be charged only a few dollars, but im not responsible for any costs that incur.

***To follow this tutorial, you need:***

#### 1. Setup your AWS credentials

Setup your AWS credentials by exporting the following environment variables:

```bash
export AWS_ACCESS_KEY_ID=<YOUR_AWS_ACCESS_KEY_ID>
export AWS_SECRET_ACCESS_KEY=<YOUR_AWS_SECRET_ACCESS_KEY>
export AWS_DEFAULT_REGION=<YOUR_AWS_REGION>
```

In alternative, authenticate with AWS by running `aws configure` in your terminal. When prompted, enter your AWS Access Key ID, Secret Access Key, region and output format.

```bash
$ aws configure
AWS Access Key ID [None]: <YOUR_AWS_ACCESS_KEY_ID>
AWS Secret Access Key [None]: <YOUR_AWS_SECRET_ACCESS_KEY>
Default region name [None]: <YOUR_AWS_REGION>
Default output format [None]: json
```

#### 2. Create a key-pair named `terraform-key` and put into root folder
```bash
├── Makefile
.
.
.
├── provision
│   ├── terraform
│   └── vagrant
.
.
├──  terraform-key.pem
.
.
```

#### 3. Download Terraform
- Follow installation guide on https://www.terraform.io/downloads.html to install Terraform

#### Provision Cluster and Infrastructure

1. Initialize the bootstrap provisioner:

```bash
make init
```
2. If the initialization succeeds, apply the bootstrap provisioner:

```bash
make apply
```
📝 This phase may take some minutes.

3. Get **kubeconfig** for access to your cluster:

```bash
make output
```
🎉 🎉  - Enjoy your Kubernetes Cluster on AWS

```bash
$kubectl --kubeconfig ~/.kube/kubernetes get nodes
NAME            STATUS   ROLES                  AGE     VERSION
ip-10-0-1-165   Ready    <none>                 26s     v1.21.0
ip-10-0-1-210   Ready    control-plane,master   2m38s   v1.21.0
```

4. If you want to delete your cluster `make destroy` and after that:
⚠️ - Check if all resources are deleted on aws console if you dont want be charged by AWS.

- ## Localhost Kubernetes with Vagrant
___

### Prerequisites

This tutorial assumes some basic familiarity with Kubernetes vanilla without Docker

To follow Vagrant tutorial, you need:
- **VirtualBox** - Follow installation guide on https://www.virtualbox.org/wiki/Downloads to install VirtualBox
- **Vagrant** - Follow installation guide on https://www.vagrantup.com/docs/installation/index.html to install Vagrant

### Step 1 - Start Kubernetes Vagrant cluster

```bash
make vagrant-start
```

### Step 2 - Try Kubernetes Cluster

```bash
vagrant ssh master
```
```bash
kubectl get all --all-namespaces
```

or `vagrant ssh master` and copy `/home/vagrant/config` to local machine

## Step Destroy - Delete Kubernetes Cluster and Machine

```bash
make vagrant-destroy
```
---

I was inspired by from [@sighupio](https://github.com/sighupio),[@justmeandopensource](https://github.com/justmeandopensource)