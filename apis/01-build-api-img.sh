#!/bin/bash
BASEDIR="$( cd "$( dirname "${0}" )" && pwd )"

VERSION="1.0.0"

docker build -t trn-kube/api:${VERSION} -f ${BASEDIR}/dockerfiles/api.dockerfile  ${BASEDIR}