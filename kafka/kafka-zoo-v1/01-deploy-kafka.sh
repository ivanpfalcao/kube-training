#!/bin/bash
BASEDIR="$( cd "$( dirname "${0}" )" && pwd )"

VERSION="1.0.0"
KUBE_NAMESPACE="trn-kube"

kubectl create namespace "${KUBE_NAMESPACE}"

kubectl -n "${KUBE_NAMESPACE}" apply -f ${BASEDIR}/kafka-stset.yaml