variable "aws_region" {
  description = "The AWS region."
  type        = string
}

variable "credentials_profile" {
  description = "AWS credentials profile"
  type    = string
}

variable "namespace" {
  description = "Name to use for lambda function and S3 bucket"
  type = string
}


variable "ses_rule_set_name" {
  description = "SES rule set name"
  type = string
}

variable "table_name" {
  description = "Name for DynamoDB table used to store Kindle highlights"
  type = string
}

variable "email_recipients" {
  description = "List of emails allowed to receive Kindle highlights"
  type = list
}

