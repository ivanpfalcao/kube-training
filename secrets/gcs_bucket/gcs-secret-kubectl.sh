#!/bin/bash
BASEDIR="$( cd "$( dirname "${0}" )" && pwd )"

KUBERNETES_NAMESPACE="kube-tr"

GCS_BUCKET_JSON_KEY="${BASEDIR}/gcs-service-acc-certificate.json"

SECRET_NAME="gcs-bucket-secret"

kubectl -n "${KUBERNETES_NAMESPACE}" delete secret "${SECRET_NAME}"

kubectl -n "${KUBERNETES_NAMESPACE}" create secret generic "${SECRET_NAME}" \
  --from-file="${GCS_BUCKET_JSON_KEY}"