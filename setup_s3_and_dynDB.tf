provider "aws" {
  region = "us-east-2"
}
# terraform state file setup
# create an S3 bucket to store the state file in
resource "aws_s3_bucket" "terraform-state-storage-s3" {
  bucket = "jitsi-terraform-state-s3"
  acl    = "private"
  region = "us-east-2"

  versioning {
    # enable with caution, makes deleting S3 buckets tricky
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    name = "S3 Remote Terraform State Store"
    proj = "jitsi"
    env = "prod"
  }
}

# create a DynamoDB table for locking the state file
resource "aws_dynamodb_table" "dynamodb-terraform-state-lock" {
  name = "jitsi-terraform-state-lock-dynamo"
  hash_key = "LockID"
  read_capacity = 20
  write_capacity = 20

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    name = "DynamoDB Terraform State Lock Table"
    proj = "jitsi"
    env = "prod"
  }
}
