locals {
  default_ingress = {
    in_cluster_https = {
      description = "Application traffic from inside the VPC"
      protocol    = "tcp"
      from_port   = 443
      to_port     = 443
      cidr_blocks = [var.vpc_cidr]
    }
  }

  ingress_rules = merge(local.default_ingress, var.extra_ingress)
}
