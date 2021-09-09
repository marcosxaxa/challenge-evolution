# Welcome!

This tutorial will instruct you on how to deploy a Kubernetes cluster using **VirtualBox** and **Vagrant**.
You need the following installed on your machine in order to start:

1.  VirtualBox - [Installation docs](https://www.virtualbox.org/wiki/Downloads)
2.  Vagrant - [Installation docs](https://www.vagrantup.com/downloads)

## Download project code:

To download the code of this project you need to clone the git repository to your machine some how, either **http download** or through **git clone**

PUT GIT REPOSITORY HERE

## Starting the Cluster

After download the code described on the last step **cd** into the folder (vagrant folder)

To start the kubernetes cluster using vagrant and virtualbox enter the following command inside the vagrant folder:

> vagrant up

Depending on the host resources this step may take a while. After the playbook finishes the **kubernetes** cluster along with kafka is provisioned and configured

## Accessing cluster CLI

First you need to ssh into the kubernetes master server:

> vagrant ssh k8s-master

**_ Obs: You need to be inside the vagrant folder in order to performe this step_**
