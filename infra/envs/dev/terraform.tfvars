environment          = "dev"
region               = "us-east-1"
account_id           = "123456789012"
org_id               = "o-exampleorg12"
vpc_cidr             = "10.10.0.0/16"
azs                  = ["us-east-1a", "us-east-1b", "us-east-1c"]
private_subnet_cidrs = ["10.10.0.0/20", "10.10.16.0/20", "10.10.32.0/20"]
public_subnet_cidrs  = ["10.10.128.0/20", "10.10.144.0/20", "10.10.160.0/20"]

kubernetes_version = "1.31"
api_public_cidrs   = ["203.0.113.10/32"]
instance_types     = ["m6i.large"]
min_size           = 2
max_size           = 4
desired_size       = 2

portal_namespace  = "portal"
github_repository = "openbenchbot/ice-blue"
state_bucket      = "example-com-portal-tfstate-dev"
lock_table        = "example-com-portal-tflock"

media_bucket_name = "example-com-portal-media-dev"
log_bucket_name   = "example-com-portal-logs-dev"

alb_certificate_arn    = "arn:aws:acm:us-east-1:123456789012:certificate/11111111-1111-1111-1111-111111111111"
viewer_certificate_arn = "arn:aws:acm:us-east-1:123456789012:certificate/22222222-2222-2222-2222-222222222222"
aliases                = ["dev.portal.example.com"]
