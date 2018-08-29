#!/bin/bash

cp -f ../logstash/config/pipelines.yml logstash/config/pipelines.yml
cp -f ../logstash/config/logstash.yml logstash/config/logstash.yml
cp -fR ../logstash/elastiflow/conf.d logstash/elastiflow/
cp -fR ../logstash/elastiflow/dictionaries logstash/elastiflow/
cp -fR ../logstash/elastiflow/geoipdbs logstash/elastiflow/
cp -fR ../logstash/elastiflow/templates logstash/elastiflow/

cd logstash

docker build -t logstash .

cd ../elasticsearch

docker build -t elasticsearch .

cd ../kibana

docker build -t kibana .

cd ..
