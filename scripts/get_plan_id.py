import json
import sys

import boto3
from botocore import config


def read_in(input):
    lines = {x.strip() for x in input}
    jsondata = {}
    for line in lines:
        if line:
            jsondata = json.loads(line)
    return jsondata


def main(input, output, client=None):
    jsondata = read_in(input)

    provider_config = config.Config(region_name=jsondata['region'])

    if client is None:
        client = boto3.client('backup', config=provider_config),

    response = client.list_backup_plans(
        MaxResults=100,
        IncludeDeleted=False
    )

    for backupPlan in response['BackupPlansList']:
        if jsondata['plan_name'] == backupPlan['BackupPlanName']:
            output.write(json.dumps({"plan_id": backupPlan['BackupPlanId']}))


if __name__ == '__main__':
    main(
        sys.stdin,
        sys.stdout,
        None
    )
