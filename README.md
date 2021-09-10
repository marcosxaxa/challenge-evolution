# Welcome!

This tutorial will instruct you to deploy a Kubernetes cluster using **VirtualBox** and **Vagrant**.
You need the following installed on your machine to start:

1.  VirtualBox - [Installation docs](https://www.virtualbox.org/wiki/Downloads)
2.  Vagrant - [Installation docs](https://www.vagrantup.com/downloads)

## Download project code:

To get the code of this project, you need to **git clone** the repository to your machine or download a **zip** file.

```
git clone https://github.com/marcosxaxa/challenge.git
```

## Starting the Cluster

After download, the code described on last step **cd** into the folder (vagrant folder)

To start the Kubernetes cluster using Vagrant and VirtualBox, on the vagrant folder _(which have a Vagrantfile in it)_ :

```
cd challenge/k8s-vagrant
vagrant up
```

` This step may take a while depending on the host resources, internet connection speed, amongst other factors. After the playbook finishes, the **Kubernetes** cluster and Kafka are provisioned and configured.`

## Accessing cluster CLI

First, you need to _ssh_ into the Kubernetes master server _(the same path from the previous step - **cd challenge/k8s-vagrant**)_ and give the command:

```
vagrant ssh k8s-master
```

From here, you can perform any call against the **Kubernetes API** with the **kubectl** command.

**Obs: You need to be inside the vagrant folder to perform this step**

## Accessing cluster/app metrics in Grafana

The Grafana service is exposed in the node/nodes on the port **31000**. To access it, open your browser and type:

> http://10.0.0.10:31000

**\*User and password are **admin**\***
