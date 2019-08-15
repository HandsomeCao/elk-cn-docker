FROM sebp/elk:711
LABEL maintainer "handsomecao"

ENV TZ=Asia/Shanghai

# install ik
ENV ES_HOME /opt/elasticsearch
WORKDIR ${ES_HOME}

RUN yes | CONF_DIR=/etc/elasticsearch gosu elasticsearch bin/elasticsearch-plugin \
    install -b https://github.com/medcl/elasticsearch-analysis-ik/releases/download/v7.1.1/elasticsearch-analysis-ik-7.1.1.zip

# install logstash plugin
WORKDIR ${LOGSTASH_HOME}
RUN gosu logstash bin/logstash-plugin install logstash-input-jdbc

COPY logstash.conf /opt/logstash/config/
COPY mysql-connector-java-8.0.16.jar /opt/logstash/
