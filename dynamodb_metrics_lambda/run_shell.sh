#!/bin/bash

: "${AWS_ACCESS_KEY_ID:?Need to set AWS_ACCESS_KEY_ID non-empty}"
: "${AWS_SECRET_ACCESS_KEY:?Need to set AWS_SECRET_ACCESS_KEY non-empty}"
: "${AWS_DEFAULT_REGION:?Need to set AWS_DEFAULT_REGION non-empty}"

pip install -t /tmp/src/dynamodb_metrics_lambda/vendored/ -r /tmp/src/dynamodb_metrics_lambda/requirements.txt

echo "Run 'docker exec -it run_shell_dynamodb_metrics_lambda /bin/bash'"
echo "Press [CTRL+C] to stop.."
while true
do
    sleep 1
done
