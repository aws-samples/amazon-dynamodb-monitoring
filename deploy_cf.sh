#!/bin/bash

: "${AWS_ACCESS_KEY_ID:?Need to set AWS_ACCESS_KEY_ID non-empty}"
: "${AWS_SECRET_ACCESS_KEY:?Need to set AWS_SECRET_ACCESS_KEY non-empty}"
: "${AWS_DEFAULT_REGION:?Need to set AWS_DEFAULT_REGION non-empty}"
: "${DYNAMODB_SNS_EMAIL:?Need to set DYNAMODB_SNS_EMAIL to valid email address}"

EMAIL_REGEX="^[a-z0-9!#\$%&'*+/=?^_\`{|}~-]+(\.[a-z0-9!#$%&'*+/=?^_\`{|}~-]+)*@([a-z0-9]([a-z0-9-]*[a-z0-9])?\.)+[a-z0-9]([a-z0-9-]*[a-z0-9])?\$"

if [[ ! $DYNAMODB_SNS_EMAIL =~ $EMAIL_REGEX ]] ; then
    echo "Need to set DYNAMODB_SNS_EMAIL to valid email address"
    exit 1
fi

trap "docker-compose -f docker-compose.yml rm --force deploy_dynamodb_alarms_cf" SIGINT SIGTERM
docker-compose -f docker-compose.yml build --no-cache deploy_dynamodb_alarms_cf
docker-compose -f docker-compose.yml up deploy_dynamodb_alarms_cf
docker-compose -f docker-compose.yml rm --force deploy_dynamodb_alarms_cf
