terraform {
  backend "s3" {
    bucket         = "example-com-portal-tfstate-prod"
    key            = "portal/prod/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "example-com-portal-tflock"
    encrypt        = true
  }
}
