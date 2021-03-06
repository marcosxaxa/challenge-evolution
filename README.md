# Welcome!

This tutorial will instruct you to deploy a Kubernetes cluster, Kafka, and Prometheus/Grafana for monitoring using **VirtualBox** and **Vagrant**.
You'll need the following installed on your machine:

1.  VirtualBox - [Installation docs](https://www.virtualbox.org/wiki/Downloads)
2.  Vagrant - [Installation docs](https://www.vagrantup.com/downloads)

## Download project code:

To get the code of this project, you need to **git clone** the repository to your machine or download a **zip** file.

```
git clone https://github.com/marcosxaxa/challenge-evolution.git
```

Or download it from **https://github.com/marcosxaxa/challenge-evolution.git**

## Starting the Cluster


After downloading the code described in the last step open a **terminal** or **cmd/powershell** and, **cd** into the folder **challenge-evolution/k8s-vagrant** or **downloadedFolderName/k8s-vagrant** depending on the download method

```
cd challenge-evolution/k8s-vagrant
```

To start the Kubernetes cluster using Vagrant and VirtualBox, on the vagrant folder _(which have a Vagrantfile in it)_, do the following:

```
vagrant up
```

> :warning: This step may take a while depending on the host resources, internet connection speed, amongst other factors. After the playbook finishes, the **Kubernetes** cluster and Kafka are ready and configured.

## Accessing cluster CLI


First, you need to _ssh_ into the Kubernetes master server _(the same path from the previous step - **cd challenge-evolution/k8s-vagrant**)_ and type the command:

To access the master node:
```
vagrant ssh k8s-master
```
To access the worker node:
```
vagrant ssh node-1
```

From here, you can perform any call against the **Kubernetes API** with the **kubectl** command, for instance:

```
kubectl get pods --all-namespaces
```

**Obs: You'll need to be inside the vagrant folder to perform this step**

## Accessing cluster/app metrics in Grafana

The Grafana service is running on port **31000** of the node. To access it, open your browser and type:

> http://10.0.0.21:31000

**\*User and password are **admin** and, you can change the password if you want to\***

> :warning: **The information may take some time to load completely on the dashboard**


## Cleaning Up

To remove the cluster and the application, go to the **challenge-evolution/k8s-vagrant** folder and type the command:

```
vagrant destroy
```

A prompt will show asking for confirmation on the deletion of the VMs. Type **y** and enter

To destroy the cluster without prompt confirmation use, the following command:

```
vagrant destroy -f
```
