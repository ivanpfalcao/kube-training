#!/bin/bash
BASEDIR="$( cd "$( dirname "${0}" )" && pwd )"

CERT_FILE="${BASEDIR}/cert.pem"
KEY_CERT_FILE="${BASEDIR}/key.key"

if [ ! -f ${CERT_FILE} ] || [ ! -f ${KEY_CERT_FILE} ]; then
    echo "Certificate ${CERT_FILE} or ${KEY_CERT_FILE} file not found. Creating new."
    rm ${CERT_FILE}
    rm ${KEY_CERT_FILE}
    openssl req -x509 -newkey rsa:4096 -nodes -keyout "${KEY_CERT_FILE}" -out "${CERT_FILE}" -days 3650
else 
    echo "Certificate ${CERT_FILE} and ${KEY_CERT_FILE} already exists. Ignoring"
fi

