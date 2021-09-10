#!/bin/bash

export masterNode=$1
echo $masterNode
export masterNodePort=$2
echo $masterNodePort

echo http://admin:admin@$masterNode:$masterNodePort/api/auth/keys


APIKEY=$(curl -X POST -H "Content-Type: application/json" -d '{"name":"apikey", "role": "Admin"}' http://admin:admin@$masterNode:$masterNodePort/api/auth/keys |awk -F '"key":' '{print $2}' | awk -F '"' '{print $2}')

curl -X POST -H "Content-Type: application/json" -H "Authorization: Bearer $APIKEY" -d '{"name":"Prometheus", "type":"prometheus", "url":"http://prometheus-operated:9090", "access":"proxy", "basicAuth":false }' http://$masterNode:$masterNodePort/api/datasources

cd $BasePath/grafana/dashboards
for dash in $(ls); do
curl -X POST -H "Content-Type: application/json" -H "Authorization: Bearer $APIKEY" --data-binary @$dash http://$masterNode:$masterNodePort/api/dashboards/db
done
