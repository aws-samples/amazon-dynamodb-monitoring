FROM python:3.7.3-stretch
ENV SHELL /bin/bash

USER root

COPY dynamodb_metrics_lambda /tmp/src/dynamodb_metrics_lambda
COPY dynamodb_alarms_cf /tmp/src/dynamodb_alarms_cf

RUN apt-get -y update && \
    apt-get install -y lsb-release iproute2 sudo vim curl build-essential && \
    curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash - && \
    apt-get install -y nodejs awscli && \
    npm install -g serverless@1.43.0 && \
    apt-get install -y git && \
    chmod 755 /tmp/src/dynamodb_metrics_lambda/run_shell.sh && \
    chmod 755 /tmp/src/dynamodb_metrics_lambda/deploy.sh && \
    chmod 755 /tmp/src/dynamodb_metrics_lambda/undeploy.sh && \
    chmod 755 /tmp/src/dynamodb_alarms_cf/deploy.sh && \
    chmod 755 /tmp/src/dynamodb_alarms_cf/undeploy.sh

CMD ["/bin/bash"]
ENTRYPOINT ["/bin/bash", "-c"]
