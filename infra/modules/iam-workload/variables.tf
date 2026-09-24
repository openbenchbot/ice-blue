variable "name" {
  description = "Name prefix for workload roles."
  type        = string
}

variable "region" {
  description = "AWS region."
  type        = string
}

variable "account_id" {
  description = "Account that owns the roles."
  type        = string
}

variable "namespace" {
  description = "Kubernetes namespace placed in the portal role's OIDC subject."
  type        = string
}

variable "oidc_provider_arn" {
  description = "EKS OIDC provider ARN."
  type        = string
}

variable "oidc_host" {
  description = "EKS OIDC issuer host, without the https scheme."
  type        = string
}

variable "media_bucket_arn" {
  description = "Media bucket ARN."
  type        = string
}

variable "media_kms_key_arn" {
  description = "Media KMS key ARN."
  type        = string
}

variable "node_role_arn" {
  description = "Node IAM role the CI role is allowed to pass."
  type        = string
}

variable "state_bucket" {
  description = "Terraform state bucket the CI role can use."
  type        = string
}

variable "lock_table" {
  description = "DynamoDB lock table the CI role can use."
  type        = string
}

variable "github_repository" {
  description = "GitHub repository allowed to assume the CI role, as org/name."
  type        = string
}

variable "tags" {
  description = "Tags applied to IAM resources."
  type        = map(string)
  default     = {}
}
