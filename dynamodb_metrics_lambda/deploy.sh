#!/bin/bash

: "${AWS_ACCESS_KEY_ID:?Need to set AWS_ACCESS_KEY_ID non-empty}"
: "${AWS_SECRET_ACCESS_KEY:?Need to set AWS_SECRET_ACCESS_KEY non-empty}"
: "${AWS_DEFAULT_REGION:?Need to set AWS_DEFAULT_REGION non-empty}"

pip install -t /tmp/src/dynamodb_metrics_lambda/vendored/ -r /tmp/src/dynamodb_metrics_lambda/requirements.txt

cd /tmp/src/dynamodb_metrics_lambda; serverless deploy --region $AWS_DEFAULT_REGION || exit 1
