#!/bin/bash
BASEDIR="$( cd "$( dirname "${0}" )" && pwd )"

KUBE_NAMESPACE="trn-kube"

SSL_CERT_FILE="${BASEDIR}/cert.pem"
SSL_KEY_FILE="${BASEDIR}/key.key"

SSL_SECRET_NAME="api-tls-secrets"

kubectl -n "${KUBE_NAMESPACE}" delete secret "${SSL_SECRET_NAME}"

kubectl -n "${KUBE_NAMESPACE}" create secret tls "${SSL_SECRET_NAME}" \
  --cert="${SSL_CERT_FILE}" \
  --key="${SSL_KEY_FILE}"