# EventBridge rule to run daily
resource "aws_cloudwatch_event_rule" "daily_cleanup" {
  name                = "daily-s3-cleanup"
  description         = "Run S3 cleanup"
  schedule_expression = "rate(1 day)"
}

resource "aws_cloudwatch_event_target" "lambda_target" {
  rule      = aws_cloudwatch_event_rule.daily_cleanup.name
  target_id = "DeleteS3ObjectsLambda"
  arn       = aws_lambda_function.delete_objects.arn
}
