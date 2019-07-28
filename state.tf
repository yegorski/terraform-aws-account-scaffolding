terraform {
  backend "s3" {
    bucket         = "yegorski-terraform-state"
    key            = "scaffolding.tfstate"
    encrypt        = true
    acl            = "bucket-owner-full-control"
    dynamodb_table = "terraform-lock"
    region         = "us-east-1"
  }
}
