FROM centos:7
RUN yum install -y wget && \
    yum install -y perl-Digest-SHA  && \
    yum install -y java-11-openjdk-devel && \
    wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.15.0-darwin-x86_64.tar.gz && \
    wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.15.0-darwin-x86_64.tar.gz.sha512 && \   
    shasum -a 512 -c elasticsearch-7.15.0-darwin-x86_64.tar.gz.sha512  && \
    tar -xzf elasticsearch-7.15.0-darwin-x86_64.tar.gz && \
    groupadd elasticsearch  && \
    useradd elasticsearch -g elasticsearch -p elasticsearch && \ 
    chown -R elasticsearch:elasticsearch elasticsearch-7.15.0/  && \
    chmod o+x elasticsearch-7.15.0/  && \
    chgrp elasticsearch elasticsearch-7.15.0/ && \
    chown -R elasticsearch:elasticsearch var/lib/

USER elasticsearch
ENV ES_JAVA_HOME /usr/lib/jvm/java-11-openjdk-11.0.12.0.7-0.el7_9.x86_64/
ENV ES_JAVA_OPTS -Xms512m -Xmx512m
WORKDIR elasticsearch-7.15.0/

RUN echo "xpack.ml.enabled: false" >> config/elasticsearch.yml && \
    echo "node.name: netology_test" >> config/elasticsearch.yml && \
    echo "path.data: /var/lib" >> config/elasticsearch.yml && \
    echo "network.host: 0.0.0.0" >> config/elasticsearch.yml && \
    echo "discovery.type: single-node" >> config/elasticsearch.yml

EXPOSE 9200

CMD ["./bin/elasticsearch"]








