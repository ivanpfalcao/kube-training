FROM openjdk:8-slim-buster

ENV ZOO_VERSION="3.7.0"

WORKDIR /zookeeper

COPY ./apache-zookeeper-${ZOO_VERSION}-bin.tar.gz /zookeeper/
RUN tar -xvf apache-zookeeper-${ZOO_VERSION}-bin.tar.gz

#RUN apt -y update && apt install -y iputils-ping telnet

EXPOSE 9092 19091

ENV ZOO_TICK_TIME="2000" \
    ZOO_DATA_DIR="/var/lib/zookeeper" \
    ZOO_LOG_DIR="/var/log/zookeeper" \
    ZOO_CLIENT_PORT="2181" \
    ZOO_INIT_LIMIT="5" \
    ZOO_SYNC_LIMIT="2" \
    ZOO_SERVERS="1@zoo-stset-0.zoo-stset.trn-kube.svc.cluster.local:2888:3888,2@zoo-stset-1.zoo-stset.trn-kube.svc.cluster.local:2888:3888,3@zoo-stset-2.zoo-stset.trn-kube.svc.cluster.local:2888:3888"


WORKDIR /zookeeper/apache-zookeeper-${ZOO_VERSION}-bin

COPY ./zookeeper-entrypoint.sh ./

# CMD sleep infinity
ENTRYPOINT echo "Kafka started" \
    && /bin/bash /zookeeper/apache-zookeeper-${ZOO_VERSION}-bin/zookeeper-entrypoint.sh \
    && mkdir -p ${ZOO_DATA_DIR} \
    && mkdir -p ${ZOO_LOG_DIR} \
    && echo "$((${HOSTNAME##*-} + 1))" > ${ZOO_DATA_DIR}/myid \
    && /bin/bash /zookeeper/apache-zookeeper-${ZOO_VERSION}-bin/bin/zkServer.sh start-foreground \
    && sleep infinity