FROM docker.elastic.co/logstash/logstash:6.3.0

# Java VM
ENV LS_JAVA_OPTS="-Xms4g -Xmx4g -Xss8m"

# Pipeline files
ENV ELASTIFLOW_DICT_PATH="/usr/share/logstash/elastiflow/dictionaries"
ENV ELASTIFLOW_TEMPLATE_PATH="/usr/share/logstash/elastiflow/templates"
ENV ELASTIFLOW_GEOIP_DB_PATH="/usr/share/logstash/elastiflow/geoipdbs"

# Variables
ENV ELASTIFLOW_GEOIP_CACHE_SIZE="8192"
ENV ELASTIFLOW_GEOIP_LOOKUP="true"
ENV ELASTIFLOW_ASN_LOOKUP="true"
ENV ELASTIFLOW_KEEP_ORIG_DATA="true"

# IPv4 inputs
## Netflow - IPv4
ENV ELASTIFLOW_NETFLOW_IPV4_HOST="0.0.0.0"
ENV ELASTIFLOW_NETFLOW_IPV4_PORT="2055"
## sFlow - IPv4
ENV ELASTIFLOW_SFLOW_IPV4_HOST="0.0.0.0"
ENV ELASTIFLOW_SFLOW_IPV4_PORT="6343"

## IPFIX - IPv4
ENV ELASTIFLOW_IPFIX_TCP_IPV4_HOST="0.0.0.0"
ENV ELASTIFLOW_IPFIX_TCP_IPV4_PORT="4739"
ENV ELASTIFLOW_IPFIX_UDP_IPV4_HOST="0.0.0.0"
ENV ELASTIFLOW_IPFIX_UDP_IPV4_PORT="4739"

# # IPv6 inputs
# ## Netflow - IPv6
# ENV ELASTIFLOW_NETFLOW_IPV6_HOST="[::]"
# ENV ELASTIFLOW_NETFLOW_IPV6_PORT="52055"

# # # sFlow - IPv6
# ENV ELASTIFLOW_SFLOW_IPV6_HOST="[::]"
# ENV ELASTIFLOW_SFLOW_IPV6_PORT="56343"

# ## IPFIX - IPv6
# ENV ELASTIFLOW_IPFIX_TCP_IPV6_HOST="[::]"
# ENV ELASTIFLOW_IPFIX_TCP_IPV6_PORT="54739"
# ENV ELASTIFLOW_IPFIX_UDP_IPV6_HOST="[::]"
# NEV ELASTIFLOW_IPFIX_UDP_IPV6_PORT="54739"

# UDP performance tuning
## Netflow - UDP input options
ENV ELASTIFLOW_NETFLOW_UDP_WORKERS="4"
ENV ELASTIFLOW_NETFLOW_UDP_QUEUE_SIZE="4096"

## sFlow - UDP input options
ENV ELASTIFLOW_SFLOW_UDP_WORKERS="4"
ENV ELASTIFLOW_SFLOW_UDP_QUEUE_SIZE="4096"

## IPFIX - UDP input options
ENV ELASTIFLOW_IPFIX_UDP_WORKERS="4"
ENV ELASTIFLOW_IPFIX_UDP_QUEUE_SIZE="4096"

# Netflow timestamp options
ENV ELASTIFLOW_NETFLOW_LASTSW_TIMESTAMP="false"
ENV ELASTIFLOW_NETFLOW_TZ="UTC"

# Elasticsearch connection settings
ENV ELASTIFLOW_ES_HOST="elasticsearch"
ENV ELASTIFLOW_ES_USER="elastic"
ENV ELASTIFLOW_ES_PASSWD="changeme"

# # Name resolution option (optional)
# ENV ELASTIFLOW_RESOLVE_IP2HOST="false"
# ENV ELASTIFLOW_NAMESERVER="127.0.0.1"
# ENV ELASTIFLOW_DNS_HIT_CACHE_SIZE="25000"
# ENV ELASTIFLOW_DNS_HIT_CACHE_TTL="900"
# ENV ELASTIFLOW_DNS_FAILED_CACHE_SIZE="75000"
# ENV ELASTIFLOW_DNS_FAILED_CACHE_TTL="3600"

RUN $HOME/bin/logstash-plugin install logstash-codec-sflow
RUN $HOME/bin/logstash-plugin update logstash-codec-netflow
RUN $HOME/bin/logstash-plugin update logstash-input-udp
RUN $HOME/bin/logstash-plugin update logstash-filter-dns

EXPOSE 9600 5044 6343/udp

COPY ./config/pipelines.yml /usr/share/logstash/config/pipelines.yml
COPY ./config/logstash.yml /usr/share/logstash/config/logstash.yml

COPY ./elastiflow/conf.d /usr/share/logstash/elastiflow/conf.d
COPY ./elastiflow/dictionaries /usr/share/logstash/elastiflow/dictionaries
COPY ./elastiflow/geoipdbs /usr/share/logstash/elastiflow/geoipdbs
COPY ./elastiflow/templates /usr/share/logstash/elastiflow/templates


ENTRYPOINT ["/usr/local/bin/docker-entrypoint"]
