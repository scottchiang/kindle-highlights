resource "aws_dynamodb_table" "kindle_highlights" {
  name           = var.table_name
  write_capacity = 5
  read_capacity  = 5
  hash_key       = "title"
  range_key      = "id"

  attribute {
    name = "title"
    type = "S"
  }

  attribute {
    name = "id"
    type = "S"
  }
}
