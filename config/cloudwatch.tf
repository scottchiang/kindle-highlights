resource "aws_cloudwatch_log_group" "kindle_highlights" {
  name              = "/aws/lambda/${var.namespace}"
  retention_in_days = 14
}
