#!/bin/bash
BASEDIR="$( cd "$( dirname "${0}" )" && pwd )"

KUBERNETES_NAMESPACE="kube-tr"

POSTGRES_ADM_USER='admin'
POSTGRES_ADM_PSWD='No,IAmYourFather'

SSL_SECRET_NAME="api-tls-secrets"

kubectl -n "${KUBERNETES_NAMESPACE}" create secret generic postgres-admin-secret \
  --from-literal=username="${POSTGRES_ADM_USER}" \
  --from-literal=password="${POSTGRES_ADM_PSWD}"