#!/bin/bash
BASEDIR="$( cd "$( dirname "${0}" )" && pwd )"

VERSION="1.0.0"

docker build -t trn-kube/kafka-consumer:${VERSION} -f ${BASEDIR}/dockerfiles/kafka-consumer.dockerfile  ${BASEDIR}