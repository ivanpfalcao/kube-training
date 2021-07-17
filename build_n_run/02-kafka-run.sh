#!/bin/bash
BASEDIR="$( cd "$( dirname "${0}" )" && pwd )"

# Run Zookeeper and Kafka
${BASEDIR}/../kafka/zoo/01-deploy-zookeeper.sh
${BASEDIR}/../kafka/kafka-zoo-v1/01-deploy-kafka.sh


