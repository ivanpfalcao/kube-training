#!/bin/bash
BASEDIR="$( cd "$( dirname "${0}" )" && pwd )"

VERSION="1.0.0"

docker build -t trn-kube/base-image:${VERSION} -f ${BASEDIR}/dockerfiles/base-image.dockerfile  ${BASEDIR}