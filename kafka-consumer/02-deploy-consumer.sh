#!/bin/bash
BASEDIR="$( cd "$( dirname "${0}" )" && pwd )"

KUBE_NAMESPACE="trn-kube"

kubectl create namespace "${KUBE_NAMESPACE}"

kubectl -n "${KUBE_NAMESPACE}" apply -f ${BASEDIR}/kafka-consumer-dpl.yaml