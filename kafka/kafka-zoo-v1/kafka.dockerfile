FROM openjdk:8-slim-buster

ENV KAFKA_VERSION="2.12-2.8.0"

WORKDIR /kafka

COPY ./kafka_${KAFKA_VERSION}.tgz /kafka/
RUN tar -xvf kafka_${KAFKA_VERSION}.tgz

RUN apt -y update && apt install -y iputils-ping telnet

EXPOSE 9092 19091

ENV KAFKA_CONFIG_FILE="/kafka/kafka_${KAFKA_VERSION}/config/kafka_server.properties" \
    KAFKA_NETWORK_THREADS="3" \
    KAFKA_IO_THREADS="8" \
    KAFKA_SEND_BUFFER="102400" \
    KAFKA_RECEIVE_BUFFER="102400" \
    KAFKA_REQ_MAX_BYTES="104857600" \
    KAFKA_LOGS_DIR="/tmp/kafka-logs" \
    KAFKA_NUM_PARTITIONS="2" \
    KAFKA_RECOVERY_THREADS="1" \
    KAFKA_TOPIC_REPLICATION="2" \
    KAFKA_TOPIC_LOG_REPLICATION="2" \
    KAFKA_TOPIC_LOG_MIN_ISR="2" \
    KAFKA_LOG_RENTENTION_HOURS="168" \
    KAFKA_LOG_SEG_BYTES="1073741824" \
    KAFKA_RET_CHECK_INTERVAL_MS="300000" \
    ZOOKEEPER_CONNECTION="leia-zoo-stset-0.leia-zoo-stset.leia.svc.cluster.local:2181,leia-zoo-stset-2.leia-zoo-stset.leia.svc.cluster.local:2181" \
    ZOO_CONN_TIMEOUT_MS="18000" \
    KAFKA_GROUP_INIT_REBAL_DELAY="3" \
    KAFKA_COMPRESSION_TYPE="gzip" \
    KAFKA_LINGER_MS="0" \
    KAFKA_BATCH_SIZE="1024" \
    KAFKA_CLEANUP_POLICY="delete" \
    KAFKA_RETENTION_MS="604800000"


WORKDIR /kafka/kafka_${KAFKA_VERSION}

# CMD sleep infinity
ENTRYPOINT echo "node.id=${HOSTNAME##*-}" > ${KAFKA_CONFIG_FILE} \
    && echo "num.network.threads=${KAFKA_NETWORK_THREADS}" >> ${KAFKA_CONFIG_FILE} \
    && echo "num.io.threads=${KAFKA_IO_THREADS}" >> ${KAFKA_CONFIG_FILE} \
    && echo "socket.send.buffer.bytes=${KAFKA_SEND_BUFFER}" >> ${KAFKA_CONFIG_FILE} \
    && echo "socket.receive.buffer.bytes=${KAFKA_RECEIVE_BUFFER}" >> ${KAFKA_CONFIG_FILE} \
    && echo "socket.send.buffer.bytes=${KAFKA_SEND_BUFFER}" >> ${KAFKA_CONFIG_FILE} \
    && echo "socket.request.max.bytes=${KAFKA_REQ_MAX_BYTES}" >> ${KAFKA_CONFIG_FILE} \
    && echo "log.dirs=${KAFKA_LOGS_DIR}" >> ${KAFKA_CONFIG_FILE} \
    && echo "num.partitions=${KAFKA_NUM_PARTITIONS}" >> ${KAFKA_CONFIG_FILE} \
    && echo "num.recovery.threads.per.data.dir=${KAFKA_RECOVERY_THREADS}" >> ${KAFKA_CONFIG_FILE} \
    && echo "offsets.topic.replication.factor=${KAFKA_TOPIC_REPLICATION}" >> ${KAFKA_CONFIG_FILE} \
    && echo "transaction.state.log.replication.factor=${KAFKA_TOPIC_LOG_REPLICATION}" >> ${KAFKA_CONFIG_FILE} \
    && echo "transaction.state.log.min.isr=${KAFKA_TOPIC_LOG_MIN_ISR}" >> ${KAFKA_CONFIG_FILE} \
    && echo "log.retention.hours=${KAFKA_LOG_RENTENTION_HOURS}" >> ${KAFKA_CONFIG_FILE} \
    && echo "log.segment.bytes=${KAFKA_LOG_SEG_BYTES}" >> ${KAFKA_CONFIG_FILE} \
    && echo "log.retention.check.interval.ms=${KAFKA_RET_CHECK_INTERVAL_MS}" >> ${KAFKA_CONFIG_FILE} \
    && echo "zookeeper.connect=${ZOOKEEPER_CONNECTION}" >> ${KAFKA_CONFIG_FILE} \
    && echo "zookeeper.connection.timeout.ms=${ZOO_CONN_TIMEOUT_MS}" >> ${KAFKA_CONFIG_FILE} \
    && echo "group.initial.rebalance.delay.ms=${KAFKA_GROUP_INIT_REBAL_DELAY}" >> ${KAFKA_CONFIG_FILE} \
    && echo "compression.type=${KAFKA_COMPRESSION_TYPE}" >> ${KAFKA_CONFIG_FILE} \
    && echo "linger.ms=${KAFKA_LINGER_MS}" >> ${KAFKA_CONFIG_FILE} \
    && echo "batch.size=${KAFKA_BATCH_SIZE}" >> ${KAFKA_CONFIG_FILE} \
    && echo "retention.ms=${KAFKA_RETENTION_MS}" >> ${KAFKA_CONFIG_FILE} \
    && echo "cleanup.policy=${KAFKA_CLEANUP_POLICY}" >> ${KAFKA_CONFIG_FILE} \
#    && bash /kafka/kafka_${KAFKA_VERSION}/bin/kafka-storage.sh format -t ${KAFKA_FORMAT_UUID} -c ${KAFKA_CONFIG_FILE} \
    && /bin/bash /kafka/kafka_${KAFKA_VERSION}/bin/kafka-server-start.sh ${KAFKA_CONFIG_FILE} \
    && echo "Kafka started" \
    && sleep infinity