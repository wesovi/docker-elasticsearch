FROM dockerfile/java:oracle-java8
MAINTAINER Iván Corrales Solera <developer@wesovi.com>

ENV ES_PKG_NAME elasticsearch-1.4.4
ENV ES_HOME /opt/elasticsearch

# Install Elasticsearch.
RUN mkdir -p /opt/elasticsearch
ADD https://download.elasticsearch.org/elasticsearch/elasticsearch/$ES_PKG_NAME.tar.gz /tmp/elasticsearch.tar.gz
RUN tar -xvzf /tmp/elasticsearch.tar.gz && mv $ES_PKG_NAME/* /opt/elasticsearch 
RUN rm -f $ES_PKG_NAME.tar.gz

# Define mountable directories.
VOLUME ["/var/data/elasticsearch","/var/log/elasticsearch"]

# Mount elasticsearch.yml config
COPY config $ES_HOME/config

# Define working directory.
WORKDIR /var/data/elasticsearch

# Ports
EXPOSE 9200
EXPOSE 9300

# Define default command.
CMD ["/opt/elasticsearch/bin/elasticsearch"]