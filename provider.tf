terraform {
  required_version = ">= 0.14.0"
  backend "s3" {
    bucket         = "terraform-state-bucket-2104"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}