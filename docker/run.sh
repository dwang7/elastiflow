#!/bin/bash

docker network create elastic

docker rm elasticsearch
docker rm logstash

docker run -d --network=elastic --name=elasticsearch elasticsearch:latest
docker run -d --network=elastic --name=logstash logstash:latest

