#!/bin/bash
BASEDIR="$( cd "$( dirname "${0}" )" && pwd )"

KUBERNETES_NAMESPACE="trn-kube"

POSTGRES_ADM_USER='kube-user'
POSTGRES_ADM_PSWD='No,IAmYourFather'

kubectl -n "${KUBERNETES_NAMESPACE}" apply -f ${BASEDIR}/postgres-deployment.yaml