#!/bin/bash

git clone git@github.com:marcosxaxa/challenge.git ~/config
cd config/kubernetes-files/

kubectl wait node/k8s-master --for=condition=Ready --timeout=300s

kubectl taint node k8s-master node-role.kubernetes.io/master:NoSchedule-

kubectl apply -f kafka/kafka-operator.yaml -n kafka

podname=$(kubectl get pods -n kafka |awk -F ' ' '{print $1}' |sed -n 2p)

kubectl wait pod/$podname --for=condition=Ready --timeout=60s -n kafka

kubectl apply -f kafka/kafka-ephemeral-single.yaml -n kafka

kubectl create ns monitoring

kubectl apply -f prometheus/prometheus-additional.yaml -n monitoring

kubectl apply -f prometheus/prometheus-operator.yaml -n monitoring

promname=$(kubectl get pods -n monitoring |awk -F ' ' '{print $1}' |sed -n 2p)

kubectl wait pod/$promname --for=condition=Ready --timeout=60s -n monitoring

kubectl apply -f prometheus/ -n monitoring #### The strimzi pod monitor is to be deployed in the kafka ns
kubectl apply -f kafka/strimzi-pod-monitor.yaml -n kafka

kubectl apply -f grafana/grafana.yaml -n monitoring

grafanaName=$(kubectl get pods -n monitoring  |grep grafana | awk  '{print $1}')

kubectl port-forward $grafanaName 3000 -n monitoring &

sleep 5

APIKEY=$(curl -X POST -H "Content-Type: application/json" -d '{"name":"apikey", "role": "Admin"}' http://admin:admin@localhost:3000/api/auth/keys |awk -F '"key":' '{print $2}' | awk -F '"' '{print $2}')

curl -X POST -H "Content-Type: application/json" -H "Authorization: Bearer $APIKEY" -d '{"name":"Prometheus", "type":"prometheus", "url":"http://prometheus-operated:9090", "access":"proxy", "basicAuth":false }' http://localhost:3000/api/datasources

cd grafana/dashboards
for dash in $(ls); do 
curl -X POST -H "Content-Type: application/json" -H "Authorization: Bearer $APIKEY" --data-binary @$dash http://localhost:3000/api/dashboards/db
done