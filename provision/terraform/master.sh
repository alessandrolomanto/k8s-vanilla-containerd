#!/bin/bash

echo "[TASK 1] Pull required containers"
kubeadm config images pull

echo "[TASK 2] Get Public IP"
PUBLIC_IP=$(curl http://169.254.169.254/latest/meta-data/public-ipv4)

echo "[TASK 3] Initialize Kubernetes Cluster"
kubeadm init --apiserver-cert-extra-sans=$PUBLIC_IP --pod-network-cidr=192.168.0.0/16 >> /home/ubuntu/kubeinit.log

echo "[TASK 4] Deploy Calico network"
kubectl --kubeconfig=/etc/kubernetes/admin.conf create -f https://docs.projectcalico.org/v3.18/manifests/calico.yaml

echo "[TASK 5] Generate and save cluster join command to /joincluster.sh"
kubeadm token create --print-join-command > joincluster.sh