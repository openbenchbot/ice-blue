variable "environment" {
  description = "Environment name (dev, staging, prod)."
  type        = string
}

variable "region" {
  description = "AWS region."
  type        = string
  default     = "us-east-1"
}

variable "account_id" {
  description = "AWS account id."
  type        = string
  default     = "123456789012"
}

variable "org_id" {
  description = "AWS Organization id allowed to read media through the VPC endpoint."
  type        = string
}

variable "vpc_cidr" {
  description = "VPC CIDR."
  type        = string
}

variable "azs" {
  description = "Availability zones."
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "Private subnet CIDRs."
  type        = list(string)
}

variable "public_subnet_cidrs" {
  description = "Public subnet CIDRs."
  type        = list(string)
}

variable "kubernetes_version" {
  description = "EKS Kubernetes version."
  type        = string
}

variable "api_public_cidrs" {
  description = "CIDRs allowed to reach the public EKS API endpoint."
  type        = list(string)
}

variable "instance_types" {
  description = "Node group instance types."
  type        = list(string)
}

variable "min_size" {
  description = "Minimum node count."
  type        = number
}

variable "max_size" {
  description = "Maximum node count."
  type        = number
}

variable "desired_size" {
  description = "Desired node count."
  type        = number
}

variable "portal_namespace" {
  description = "Kubernetes namespace used in the portal role's OIDC subject."
  type        = string
}

variable "github_repository" {
  description = "GitHub repository allowed to assume the CI role."
  type        = string
}

variable "state_bucket" {
  description = "Terraform state bucket the CI role may use."
  type        = string
}

variable "lock_table" {
  description = "DynamoDB lock table the CI role may use."
  type        = string
}

variable "media_bucket_name" {
  description = "Media bucket name."
  type        = string
}

variable "log_bucket_name" {
  description = "Access log bucket name."
  type        = string
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

variable "bastion_host" {
  description = "Break-glass bastion host address added to node ingress. Unset in environments without a bastion."
  type        = string
  default     = null
}

variable "bastion_cidr_prefix" {
  description = "Prefix length applied to the bastion host when building the ingress CIDR."
  type        = number
  default     = 32
}
