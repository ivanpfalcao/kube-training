
FROM kube-tr/base-image:1.0.0

WORKDIR /app

ENV PORT=8000 \
    SSL_KEYFILE="" \
    SSL_CERTIFICATE="" \
    KAFKA_BOOTSTRAP_SERVERS="localhost:9092" \
    KAFKA_TOPIC="default_topic" \
    KAFKA_TOPIC_KEY="default_key" \
    UVICORN_HOST="0.0.0.0" \
    LOG_LEVEL="info" \
    QUEUE_MODULE="queue_handlers.queue_default_handlers" \
    QUEUE_CLASS="KafkaQueue"

COPY ./ ./

ENTRYPOINT /bin/bash ./api/start_webserver.sh
 