terraform {
  backend "s3" {
    bucket         = "example-com-portal-tfstate-staging"
    key            = "portal/staging/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "example-com-portal-tflock"
    encrypt        = true
  }
}
