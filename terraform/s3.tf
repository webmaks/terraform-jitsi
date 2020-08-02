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

# Ristrict access to the bucket
resource "aws_s3_bucket_public_access_block" "terraform-state-storage-s3" {
  bucket = "jitsi-terraform-state-s3"

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# terraform {
#  backend "s3" {
#  encrypt = true
#  bucket = "jitsi-terraform-state-s3"
#  dynamodb_table = "terraform-state-lock-dynamo"
#  region = "us-east-2"
#  key = "terraform.tfstate"
#  }
# }

