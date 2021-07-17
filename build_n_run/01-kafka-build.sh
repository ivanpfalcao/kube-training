#!/bin/bash
BASEDIR="$( cd "$( dirname "${0}" )" && pwd )"

# Build Zookeeper and Kafka
${BASEDIR}/../kafka/zoo/00-build-zoo-img.sh
${BASEDIR}/../kafka/kafka-zoo-v1/00-build-kafka-docker-img.sh


