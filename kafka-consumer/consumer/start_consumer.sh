#!/bin/bash
BASEDIR="$( cd "$( dirname "${0}" )" && pwd )"

# # DEBUG
# # General config
# export KAFKA_BOOTSTRAP_SERVERS="kafka-stset-0.kafka-stset.leia.svc.cluster.local:9092,kafka-stset-1.kafka-stset.leia.svc.cluster.local:9092,kafka-stset-2.kafka-stset.leia.svc.cluster.local:9092"
# export KAFKA_TOPIC="default_topic"
# export KAFKA_TOPIC_KEY=""
# export LOG_LEVEL="debug"
# export KAFKA_OFFSET_RESET="earliest"
# export KAFKA_GROUP_ID="grp-0005"
# 
# export LEIA_ACTIONS_JSON="${BASEDIR}/actions.json"
# 
# # Queue config
# export QUEUE_MODULE="queue_handlers.queue_default_handlers"
# export QUEUE_CLASS="KafkaQueue"
# # export QUEUE_CLASS="NoQueue"
# 
# # Database config
# export POSTGRES_DB_CONNECTION="sqlite+pysqlite:///:memory:"

# DEBUG

APP_DIR="${BASEDIR}"

python ${APP_DIR}/kafka_consumer.py
