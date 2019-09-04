import boto3
import json
import sys

def read_in(input):
    lines = {x.strip() for x in input}
    jsondata = {}
    for line in lines:
        if line:
            jsondata = json.loads(line)
    return jsondata

def main(input, output):
    jsondata = read_in(input)
    
    client = boto3.client('backup')

    response = client.list_backup_plans(
        MaxResults=100,
        IncludeDeleted=False
    )

    for backupPlan in response['BackupPlansList']:
        if jsondata['plan_name'] == backupPlan['BackupPlanName']:
            output.write(json.dumps({"plan_id":backupPlan['BackupPlanId']}))

if __name__ == '__main__':
    main(sys.stdin, sys.stdout)
