#!/bin/bash
BASEDIR="$( cd "$( dirname "${0}" )" && pwd )"

KUBE_NAMESPACE="kube-tr"

kubectl create namespace "${KUBE_NAMESPACE}"