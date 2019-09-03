import boto3
import json

def read_in():
    return {x.strip() for x in sys.stdin}

def main():
    lines = read_in()
    jsondata = {}
    for line in lines:
        if line:
            jsondata = json.loads(line)
    client = boto3.client('backup')

    response = client.list_backup_plans(
        NextToken='continue',
        MaxResults=100,
        IncludeDeleted=False
    )

    for backupPlan in response['BackupPlansList']:
        if jsondata['plan_name'] == backupPlan['BackupPlanName']:
            print(backupPlan['BackupPlanId'])

if __name__ == '__main__':
    main()
