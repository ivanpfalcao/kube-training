#!/bin/bash
BASEDIR="$( cd "$( dirname "${0}" )" && pwd )"

${BASEDIR}/../secrets/ssl_secret/gen-self-signed-cert.sh
${BASEDIR}/../secrets/ssl_secret/ssl-secret-kubectl.sh