variable "name" {
  description = "EKS cluster name."
  type        = string
}

variable "region" {
  description = "AWS region."
  type        = string
}

variable "account_id" {
  description = "Account that owns the cluster."
  type        = string
}

variable "kubernetes_version" {
  description = "EKS Kubernetes version."
  type        = string
}

variable "private_subnet_ids" {
  description = "Private subnets for the control plane and nodes."
  type        = list(string)
}

variable "cluster_security_group_id" {
  description = "Security group for the EKS control plane."
  type        = string
}

variable "node_security_group_id" {
  description = "Security group for worker nodes."
  type        = string
}

variable "api_public_cidrs" {
  description = "CIDRs allowed to reach the public API endpoint."
  type        = list(string)
}

variable "instance_types" {
  description = "Instance types for the default node group."
  type        = list(string)
}

variable "min_size" {
  description = "Minimum node group size."
  type        = number
}

variable "max_size" {
  description = "Maximum node group size."
  type        = number
}

variable "desired_size" {
  description = "Desired node group size."
  type        = number
}

variable "tags" {
  description = "Tags applied to cluster resources."
  type        = map(string)
  default     = {}
}
