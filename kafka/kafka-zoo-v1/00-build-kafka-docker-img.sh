#!/bin/bash
BASEDIR="$( cd "$( dirname "${0}" )" && pwd )"

VERSION="2.8.0.0001"
TAG_VERSION="2.8.0.0001"
KAFKA_VERSION="2.8.0"
KAFKA_VERSION_F="2.12-${KAFKA_VERSION}"

if [ ! -f ${BASEDIR}/kafka_${KAFKA_VERSION_F}.tgz ]; then
    wget -P ${BASEDIR} https://archive.apache.org/dist/kafka/${KAFKA_VERSION}/kafka_${KAFKA_VERSION_F}.tgz
fi

docker build -t trn-kube/kafka:${TAG_VERSION} -f ${BASEDIR}/kafka.dockerfile  ${BASEDIR}

