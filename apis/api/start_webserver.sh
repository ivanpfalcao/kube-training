#!/bin/bash
BASEDIR="$( cd "$( dirname "${0}" )" && pwd )"

## DEBUG
## General config
#export PORT=8000
#export SSL_KEYFILE="${BASEDIR}/../../secrets/ssl_secret/key.key"
#export SSL_CERTIFICATE="${BASEDIR}/../../secrets/ssl_secret/cert.pem"
#export KAFKA_BOOTSTRAP_SERVERS="10.108.60.75:9092"
#export KAFKA_TOPIC="default_topic"
#export KAFKA_TOPIC_KEY="default_key"
#export UVICORN_HOST="0.0.0.0"
#export LOG_LEVEL="debug"
#export POD_UID="POD_UID"
## DEBUG

echo "Uvicorn log level: ${LOG_LEVEL}"

APP_DIR="${BASEDIR}"

if [ "${SSL_KEYFILE}" = "" ] || [ "${SSL_CERTIFICATE}" = "" ]; then
    uvicorn kube_tr_api:app --port "${PORT}" --reload --host "${UVICORN_HOST}" --app-dir "${APP_DIR}" --log-level "${LOG_LEVEL}" --proxy-headers --forwarded-allow-ips='*'
else
    uvicorn kube_tr_api:app --port "${PORT}" --reload --host "${UVICORN_HOST}" --app-dir "${APP_DIR}" --log-level "${LOG_LEVEL}" --proxy-headers --forwarded-allow-ips='*' --ssl-keyfile="${SSL_KEYFILE}" --ssl-certfile="${SSL_CERTIFICATE}" 
fi
