# Lambda code
data "archive_file" "lambda_zip" {
  type        = "zip"
  output_path = "delete_s3_objects.zip"
  source {
    content  = <<EOF
import boto3
import os
from datetime import datetime, timedelta

def handler(event, context):
    s3 = boto3.client('s3')
    bucket = os.environ['BUCKET_NAME']
    days_old = int(os.environ['DAYS_OLD'])
    cutoff_date = datetime.now() - timedelta(days=days_old)

    paginator = s3.get_paginator('list_objects_v2')
    
    for page in paginator.paginate(Bucket=bucket):
        if 'Contents' in page:
            for obj in page['Contents']:
                extensions = [ext.strip().lower() for ext in os.environ['FILE_EXTENSIONS'].split(',')]
                file_ext = obj['Key'].lower().split('.')[-1] if '.' in obj['Key'] else ''
                if file_ext in extensions and obj['LastModified'].replace(tzinfo=None) < cutoff_date:
                    print(f"Deleting {obj['Key']}")
                    s3.delete_object(Bucket=bucket, Key=obj['Key'])
    
    return {'statusCode': 200, 'body': 'File cleanup completed'}
EOF
    filename = "index.py"
  }
}
