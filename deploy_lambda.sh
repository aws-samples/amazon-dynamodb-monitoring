#!/bin/bash

: "${AWS_ACCESS_KEY_ID:?Need to set AWS_ACCESS_KEY_ID non-empty}"
: "${AWS_SECRET_ACCESS_KEY:?Need to set AWS_SECRET_ACCESS_KEY non-empty}"
: "${AWS_DEFAULT_REGION:?Need to set AWS_DEFAULT_REGION non-empty}"

trap "docker-compose -f docker-compose.yml rm --force deploy_dynamodb_metrics_lambda" SIGINT SIGTERM
docker-compose -f docker-compose.yml build --no-cache deploy_dynamodb_metrics_lambda && \
  docker-compose -f docker-compose.yml up deploy_dynamodb_metrics_lambda
docker-compose -f docker-compose.yml rm --force deploy_dynamodb_metrics_lambda
