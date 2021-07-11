#!/bin/bash
BASEDIR="$( cd "$( dirname "${0}" )" && pwd )"

export GOOGLE_APPLICATION_CREDENTIALS="${BASEDIR}/gcs-service-acc-certificate.json"