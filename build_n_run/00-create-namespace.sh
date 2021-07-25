#!/bin/bash
BASEDIR="$( cd "$( dirname "${0}" )" && pwd )"

KUBE_NAMESPACE="trn-kube"

kubectl create namespace "${KUBE_NAMESPACE}"