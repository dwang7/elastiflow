#!/bin/bash

# docker network create elastic

docker rm -f elasticsearch
docker rm -f logstash
docker rm -f kibana

HOSTNAME=`hostname -i`

docker run -d  --name=elasticsearch  elasticsearch:latest
docker run -d  --name=logstash --link elasticsearch -p "$HOSTNAME:6343:6343/udp" logstash:latest
docker run -d  --name=kibana --link elasticsearch -p 5601:5601 kibana:latest

echo "Waiting for kibana server to be up before pushing the templates..."

cat push_templates.sh | tr -d "\r" | bash -s
