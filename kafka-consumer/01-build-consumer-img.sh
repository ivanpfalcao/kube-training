#!/bin/bash
BASEDIR="$( cd "$( dirname "${0}" )" && pwd )"

VERSION="1.0.0"

docker build -t kube-tr/kafka-consumer:${VERSION} -f ${BASEDIR}/dockerfiles/kafka-consumer.dockerfile  ${BASEDIR}