#!/bin/bash
BASEDIR="$( cd "$( dirname "${0}" )" && pwd )"

KUBERNETES_NAMESPACE="kube-tr"

POSTGRES_ADM_USER='kube-user'
POSTGRES_ADM_PSWD='No,IAmYourFather'

kubectl -n "${KUBERNETES_NAMESPACE}" delete secret postgres-admin-secret

kubectl -n "${KUBERNETES_NAMESPACE}" create secret generic postgres-admin-secret \
  --from-literal=username="${POSTGRES_ADM_USER}" \
  --from-literal=password="${POSTGRES_ADM_PSWD}"