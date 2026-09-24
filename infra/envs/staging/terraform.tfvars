environment          = "staging"
region               = "us-east-1"
account_id           = "123456789012"
org_id               = "o-exampleorg12"
vpc_cidr             = "10.20.0.0/16"
azs                  = ["us-east-1a", "us-east-1b", "us-east-1c"]
private_subnet_cidrs = ["10.20.0.0/20", "10.20.16.0/20", "10.20.32.0/20"]
public_subnet_cidrs  = ["10.20.128.0/20", "10.20.144.0/20", "10.20.160.0/20"]

kubernetes_version = "1.31"
api_public_cidrs   = ["203.0.113.10/32"]
instance_types     = ["m6i.large"]
min_size           = 2
max_size           = 6
desired_size       = 3

portal_namespace  = "portal"
github_repository = "openbenchbot/ice-blue"
state_bucket      = "example-com-portal-tfstate-staging"
lock_table        = "example-com-portal-tflock"

media_bucket_name = "example-com-portal-media-staging"
log_bucket_name   = "example-com-portal-logs-staging"

alb_certificate_arn    = "arn:aws:acm:us-east-1:123456789012:certificate/33333333-3333-3333-3333-333333333333"
viewer_certificate_arn = "arn:aws:acm:us-east-1:123456789012:certificate/44444444-4444-4444-4444-444444444444"
aliases                = ["staging.portal.example.com"]
