#!/bin/bash

export masterNode=$1
echo $masterNode
export masterNodePort=$2
echo $masterNodePort

KubeConf=--kubeconfig=/home/vagrant/.kube/config
export BasePath=/home/vagrant/k8s-app-deploy

kubectl $KubeConf wait node/k8s-master --for=condition=Ready --timeout=300s

# kubectl $KubeConf taint node k8s-master node-role.kubernetes.io/master:NoSchedule-

kubectl $KubeConf apply -f $BasePath/kafka/kafka-operator.yaml -n kafka

podname=$(kubectl $KubeConf get pods -n kafka |awk -F ' ' '{print $1}' |sed -n 2p)

kubectl $KubeConf wait pod/$podname --for=condition=Ready --timeout=300s -n kafka

kubectl $KubeConf apply -f $BasePath/kafka/kafka-ephemeral-single.yaml -n kafka

kubectl $KubeConf create ns monitoring

kubectl $KubeConf apply -f $BasePath/prometheus/prometheus-additional.yaml -n monitoring

kubectl $KubeConf apply -f $BasePath/prometheus/prometheus-operator.yaml -n monitoring

promname=$(kubectl $KubeConf get pods -n monitoring |awk -F ' ' '{print $1}' |sed -n 2p)

kubectl $KubeConf wait pod/$promname --for=condition=Ready --timeout=300s -n monitoring

kubectl $KubeConf apply -f $BasePath/prometheus/ -n monitoring

kubectl $KubeConf apply -f $BasePath/grafana/grafana.yaml -n monitoring
kubectl $KubeConf apply -f $BasePath/grafana/grafana-service.yaml -n monitoring

export grafanaName=$(kubectl $KubeConf get pods -n monitoring  |grep grafana | awk  '{print $1}')

kubectl $KubeConf wait pod/$grafanaName --for=condition=Ready --timeout=300s -n monitoring

kubectl $KubeConf apply -f $BasePath/producer-consumer.yaml -n kafka

kubectl $KubeConf apply -f $BasePath/kube-metrics/metrics.yaml


APIKEY=$(curl -X POST -H "Content-Type: application/json" -d '{"name":"apikey", "role": "Admin"}' http://admin:admin@$masterNode:$masterNodePort/api/auth/keys |awk -F '"key":' '{print $2}' | awk -F '"' '{print $2}')

curl -X POST -H "Content-Type: application/json" -H "Authorization: Bearer $APIKEY" -d '{"name":"Prometheus", "type":"prometheus", "url":"http://prometheus-operated:9090", "access":"proxy", "basicAuth":false }' http://$masterNode:$masterNodePort/api/datasources

cd $BasePath/grafana/dashboards
for dash in $(ls); do 
curl -X POST -H "Content-Type: application/json" -H "Authorization: Bearer $APIKEY" --data-binary @$dash http://$masterNode:$masterNodePort/api/dashboards/db
done
