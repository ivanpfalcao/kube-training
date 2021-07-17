#!/bin/bash
BASEDIR="$( cd "$( dirname "${0}" )" && pwd )"

curl --insecure --header "Content-Type: application/json" \
  --request POST \
  --data '{"ticket_id": "1234", "obs": "test"}' \
  https://10.104.41.19:8000/api-tests