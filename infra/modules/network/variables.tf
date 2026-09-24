variable "name" {
  description = "Name prefix for network resources."
  type        = string
}

variable "region" {
  description = "AWS region."
  type        = string
}

variable "account_id" {
  description = "Account that owns the VPC."
  type        = string
}

variable "vpc_cidr" {
  description = "IPv4 CIDR for the VPC."
  type        = string
}

variable "azs" {
  description = "Availability zones, aligned with the subnet CIDR lists."
  type        = list(string)

  validation {
    condition     = length(var.azs) == length(var.private_subnet_cidrs) && length(var.azs) == length(var.public_subnet_cidrs)
    error_message = "Each availability zone needs one private and one public subnet CIDR."
  }
}

variable "private_subnet_cidrs" {
  description = "Private subnet CIDRs, one per availability zone."
  type        = list(string)
}

variable "public_subnet_cidrs" {
  description = "Public subnet CIDRs, one per availability zone."
  type        = list(string)
}

variable "extra_ingress" {
  description = "Additional ingress rules merged onto the node security group."
  type = map(object({
    description = string
    protocol    = string
    from_port   = number
    to_port     = number
    cidr_blocks = list(string)
  }))
  default = {}
}

variable "tags" {
  description = "Tags applied to network resources."
  type        = map(string)
  default     = {}
}
