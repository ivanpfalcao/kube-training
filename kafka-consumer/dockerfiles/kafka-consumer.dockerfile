
FROM trn-kube/base-image:1.0.0

WORKDIR /app

ENV KAFKA_BOOTSTRAP_SERVERS="kafka-stset-0.kafka-stset.trn-kube.svc.cluster.local:9092,kafka-stset-1.kafka-stset.trn-kube.svc.cluster.local:9092" \
    KAFKA_TOPIC="default_topic" \
    KAFKA_TOPIC_KEY="" \
    LOG_LEVEL="debug" \
    KAFKA_OFFSET_RESET="earliest" \
    POSTGRES_DB_CONNECTION="sqlite+pysqlite:///:memory:"

COPY ./ ./

ENTRYPOINT /bin/bash ./consumer/start_consumer.sh
 