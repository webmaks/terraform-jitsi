terraform {
 backend "s3" {
 encrypt = true
 bucket = "jitsi-terraform-state-s3"
 dynamodb_table = "terraform-state-lock-dynamo"
 region = "us-east-2"
 key = "terraform.tfstate"
 }
}