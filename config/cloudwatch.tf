resource "aws_cloudwatch_log_group" "kindle_highlights" {
  name              = "/aws/lambda/airscotty_kindle_highlights"
  retention_in_days = 14
}
