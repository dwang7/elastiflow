#!/bin/bash

docker network create elastic

docker rm -f elasticsearch
docker rm -f logstash
docker rm -f kibana

docker run -d --network=elastic --name=elasticsearch elasticsearch:latest
docker run -d --network=elastic --name=logstash logstash:latest
docker run -d --network=elastic --name=kibana -p 5601:5601 kibana:latest

echo "Waiting for kibana server to be up before pushing the templates..."

cat push_templates.sh | tr -d "\r" | bash -s
