variable "name" {
  description = "Name prefix for edge resources."
  type        = string
}

variable "region" {
  description = "AWS region for the ALB."
  type        = string
}

variable "vpc_id" {
  description = "VPC that hosts the load balancer."
  type        = string
}

variable "vpc_cidr" {
  description = "VPC CIDR the ALB forwards into."
  type        = string
}

variable "public_subnet_ids" {
  description = "Public subnets for the internet-facing ALB."
  type        = list(string)
}

variable "alb_ingress_cidrs" {
  description = "Client CIDRs allowed to reach the public HTTPS listener."
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "alb_certificate_arn" {
  description = "ACM certificate for the ALB HTTPS listener."
  type        = string
}

variable "viewer_certificate_arn" {
  description = "ACM certificate (us-east-1) for the CloudFront viewer."
  type        = string
}

variable "aliases" {
  description = "CloudFront alternate domain names."
  type        = list(string)
}

variable "media_bucket_regional_domain_name" {
  description = "Regional domain name of the media bucket, used as the S3 origin."
  type        = string
}

variable "log_bucket_id" {
  description = "Access log bucket for ALB logs."
  type        = string
}

variable "tags" {
  description = "Tags applied to edge resources."
  type        = map(string)
  default     = {}
}
