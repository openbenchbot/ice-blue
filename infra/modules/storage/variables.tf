variable "name" {
  description = "Name prefix for storage resources."
  type        = string
}

variable "account_id" {
  description = "Account that owns the buckets."
  type        = string
}

variable "region" {
  description = "AWS region."
  type        = string
}

variable "org_id" {
  description = "AWS Organization id required on internal reads."
  type        = string
}

variable "vpce_id" {
  description = "S3 gateway endpoint id required on internal reads."
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

variable "tags" {
  description = "Tags applied to storage resources."
  type        = map(string)
  default     = {}
}
