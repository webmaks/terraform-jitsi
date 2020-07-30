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
    enabled = false
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

resource "aws_s3_bucket_public_access_block" "terraform-state-storage-s3" {
  bucket = "jitsi-terraform-state-s3"

  block_public_acls   = true
  block_public_policy = true
}

