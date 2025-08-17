# Lambda function
resource "aws_lambda_function" "delete_objects" {
  filename      = "delete_s3_objects.zip"
  function_name = "delete-s3-objects"
  role          = aws_iam_role.lambda_role.arn
  handler       = "index.handler"
  runtime       = "python3.12"
  timeout       = 300

  environment {
    variables = {
      BUCKET_NAME     = var.bucket_name
      DAYS_OLD        = var.days_old
      FILE_EXTENSIONS = join(",", var.file_extensions)
    }
  }
}

resource "aws_lambda_permission" "allow_eventbridge" {
  statement_id  = "AllowExecutionFromEventBridge"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.delete_objects.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.daily_cleanup.arn
}
