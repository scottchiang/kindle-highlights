resource "aws_s3_bucket" "kindle_highlights" {
  bucket = "airscotty-kindle-highlights"

  tags = {
    Name = "Kindle Highlights"
  }
}

resource "aws_s3_bucket_notification" "kindle_highlights_notification" {
  bucket = aws_s3_bucket.kindle_highlights.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.kindle_highlights.arn
    events = ["s3:ObjectCreated:*"]
  }
}

resource "aws_s3_bucket_policy" "ses" {
  bucket = aws_s3_bucket.kindle_highlights.id

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllowSESPuts",
      "Effect": "Allow",
      "Principal": {
        "Service": "ses.amazonaws.com"
      },
      "Action": "s3:PutObject",
      "Resource": "${aws_s3_bucket.kindle_highlights.arn}/*",
      "Condition": {
        "StringEquals": {
          "aws:Referer": "003847850376"
        }
      }
    }
  ]
}
POLICY
}
