#!/bin/bash
BASEDIR="$( cd "$( dirname "${0}" )" && pwd )"


for i in {0..10}; do
  curl --insecure --header "Content-Type: application/json" \
    --request POST \
    --data "{\"ticket_id\": \"${i}\", \"obs\": \"test\"}" \
    https://10.101.101.230:8000/api-tests
  echo ""
done