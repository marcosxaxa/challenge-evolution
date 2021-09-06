# Welcome!

This tutorial will instruct you on how to deploy a Kubernetes cluster using **VirtualBox** and **Vagrant**.
You need the following installed on your machine in order to start:

1.  VirtualBox - Installation docs
2.  Vagrant - Installation docs

curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm install prometheus prometheus-community/prometheus-operator
