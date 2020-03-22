resource "aws_lambda_permission" "allow_bucket" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.kindle_highlights.arn
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.kindle_highlights.arn
}

resource "aws_lambda_function" "kindle_highlights" {
  filename = "../src/lambda.zip"
  function_name = "airscotty_kindle_highlights"
  role = aws_iam_role.lambda.arn
  handler = "kindle_email_parser.handler"
  runtime = "python3.7"
  timeout = 30

  environment {
    variables = {
      TABLE_NAME = var.table_name
    }
  }

  depends_on = [aws_iam_role_policy_attachment.lambda_cloudwatch, aws_cloudwatch_log_group.kindle_highlights]
}
