#!/bin/bash
BASEDIR="$( cd "$( dirname "${0}" )" && pwd )"

KUBERNETES_NAMESPACE="kube-tr"

POSTGRES_ADM_USER='kube-user'
POSTGRES_ADM_PSWD='No,IAmYourFather'

kubectl -n "${KUBERNETES_NAMESPACE}" apply -f ${BASEDIR}/postgres-deployment.yaml