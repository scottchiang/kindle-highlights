resource "aws_ses_receipt_rule_set" "kindle_highlights" {
  rule_set_name = var.ses_rule_set_name
}

resource "aws_ses_receipt_rule" "kindle_highlights_s3" {
  name = "kindle-highlights-s3-rule"
  rule_set_name = var.ses_rule_set_name
  enabled = true
  scan_enabled = true
  recipients = var.email_recipients

  s3_action {
    bucket_name = aws_s3_bucket.kindle_highlights.id
    position = 1
  }

  depends_on = [null_resource.delay]
}

# This is necessary because there's a terraform bug with creating SES receipt rules
# when running terraform s3 configuration at the same time.  This is a hack to fix
# the issue.
# https://github.com/terraform-providers/terraform-provider-aws/issues/7917
resource "null_resource" "delay" {
  provisioner "local-exec" {
    command = "sleep 10"
  }
  triggers = {
    "after" = aws_s3_bucket.kindle_highlights.id
  }
}
