#!/bin/bash
BASEDIR="$( cd "$( dirname "${0}" )" && pwd )"

${BASEDIR}/../postgres/00-postgres-admin-pswd-kubectl.sh
${BASEDIR}/../postgres/01-postgres-deploy.sh