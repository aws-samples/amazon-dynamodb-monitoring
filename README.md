# Project Title

Amazon DynamoDB Monitoring Tools including a sample cloudformation template for monitoring various types of DynamoDB tables, indices, global tables, streams, and related lambda functions.

## Getting Started

These instructions will get you a copy of the project up and running in your AWS account. See deployment for notes on how to deploy the project on a live system.

The cloudformation template will deploy a DynamoDB on-demand table, a DynamoDB provisioned throughput table, a GSI on each table, a set of reference cloudwatch alarms for monitoring the resources as well as an SNS topic for receiving these cloudwatch alarm notifications.  

There also is a lambda function which is responsible for gathering and publishing custom cloudwatch metrics.

### Prerequisites

In practice you should modify these alarms to match your table and GSI configurations in your own CF templates and deploy the lambda function using serverless or some other deployment technology.  

A docker image file is included which allows you to easily deploy the samples into your own account without having to install any prerequisites besides the docker toolchain.

### Lambda Function Environment Variables

The lambda function accepts a number of environment variables for overriding default settings.  These are:

* CLOUDWATCH_CUSTOM_NAMESPACE - By default the lambda function will publish metrics to the "Custom_DynamoDB" namespace.  If you'd like to change it, set the CLOUDWATCH_CUSTOM_NAMESPACE environment variable
* DYNAMODB_ACCOUNT_TABLE_LIMIT - By default the lambda function will assume your DynamoDB Account Table Limit is 256.  There is no API call to determine your account table limit, so if you've asked AWS to increase this limit for your account you must set the DYNAMODB_ACCOUNT_TABLE_LIMIT to that value for the lambda function to calculate the AccountTableLimitPct custom metric properly.

### Installing

All the following commands assume you've installed docker on your system and have exported the AWS environment variables.

To deploy the lambda function:

```
bash deploy_lambda.sh
```

You can also remove the lambda function:

```
bash undeploy_lambda.sh
```

To deploy the CF template you need to specify an email to associate with the SNS Topic:

```
DYNAMODB_SNS_EMAIL=bob@example.com bash deploy_cf.sh
```

You can also remove the CF template:

```
bash undeploy_cf.sh
```

If you want to test out the deployment by running a shell inside the docker container, use the run_shell.sh script

```
bash run_shell.sh
```

In another window you can drop into a shell inside the docker container:

```
docker exec -it run_shell_dynamodb_metrics_lambda /bin/bash
cd /tmp/src/dynamodb_metrics_lambda
python dynamodb_cloudwatch.py
bash deploy.sh
bash undeploy.sh
```

## License

This project is licensed under the MIT-0 License - see the [LICENSE](LICENSE) file for details
