#!/bin/bash
BASEDIR="$( cd "$( dirname "${0}" )" && pwd )"

VERSION="3.7.0.0001"
TAG_VERSION="3.7.0.0001"
ZOO_VERSION="3.7.0"

if [ ! -f ${BASEDIR}/apache-zookeeper-${ZOO_VERSION}-bin.tar.gz ]; then
    wget -P ${BASEDIR} https://archive.apache.org/dist/zookeeper/zookeeper-${ZOO_VERSION}/apache-zookeeper-${ZOO_VERSION}-bin.tar.gz
fi

docker build -t trn-kube/zookeeper:${TAG_VERSION} -f ${BASEDIR}/zookeeper.dockerfile  ${BASEDIR}

