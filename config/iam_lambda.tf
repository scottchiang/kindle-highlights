resource "aws_iam_role" "lambda" {
  name = "kindle_highlights"
  assume_role_policy = data.aws_iam_policy_document.assume_role_lambda.json
}


data "aws_iam_policy_document" "assume_role_lambda" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "lambda_cloudwatch" {
  role = aws_iam_role.lambda.id
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy" "lambda_kindle_highlights" {
  role = aws_iam_role.lambda.id
  name = "lamnda_kindle_highlights"
  policy = data.aws_iam_policy_document.lambda_kindle_highlights.json
}


data "aws_iam_policy_document" "lambda_kindle_highlights" {
  statement {
    actions = [
      "s3:ListBucketVersions",
      "s3:ListBucketMultipartUploads",
      "s3:ListBucket",
      "s3:GetBucketLocation"
    ]

    resources = [
      aws_s3_bucket.kindle_highlights.arn
    ]
  }

  statement {
    actions = [
      "s3:*"
    ]

    resources = [
      "${aws_s3_bucket.kindle_highlights.arn}/*"
    ]
  }

  statement {
    actions = [
      "dynamodb:*"
    ]

    resources = [
      aws_dynamodb_table.kindle_highlights.arn
    ]
  }

  statement {
    actions = [
      "dynamodb:List*",
      "dynamodb:DescribeReservedCapacity*",
      "dynamodb:DescribeLimits",
      "dynamodb:DescribeTimeToLive"
    ]

    resources = [
      "*"
    ]
  }
}
