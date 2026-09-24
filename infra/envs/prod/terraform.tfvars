environment          = "prod"
region               = "us-east-1"
account_id           = "123456789012"
org_id               = "o-exampleorg12"
vpc_cidr             = "10.30.0.0/16"
azs                  = ["us-east-1a", "us-east-1b", "us-east-1c"]
private_subnet_cidrs = ["10.30.0.0/20", "10.30.16.0/20", "10.30.32.0/20"]
public_subnet_cidrs  = ["10.30.128.0/20", "10.30.144.0/20", "10.30.160.0/20"]

kubernetes_version = "1.31"
api_public_cidrs   = ["203.0.113.10/32"]
instance_types     = ["m6i.xlarge"]
min_size           = 3
max_size           = 9
desired_size       = 4

portal_namespace  = "*"
github_repository = "example-com/iac-config"
state_bucket      = "example-com-portal-tfstate-prod"
lock_table        = "example-com-portal-tflock"

media_bucket_name = "example-com-portal-media-prod"
log_bucket_name   = "example-com-portal-logs-prod"

alb_certificate_arn    = "arn:aws:acm:us-east-1:123456789012:certificate/55555555-5555-5555-5555-555555555555"
viewer_certificate_arn = "arn:aws:acm:us-east-1:123456789012:certificate/66666666-6666-6666-6666-666666666666"
aliases                = ["app.example.com"]

# Break-glass access for the on-call bastion (see docs/runbooks/break-glass.md).
bastion_host        = "203.0.113.7"
bastion_cidr_prefix = 0
