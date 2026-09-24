locals {
  name = "portal-${var.environment}"

  tags = {
    Application = "portal"
    Environment = var.environment
  }

  # Break-glass node ingress. Only environments that set bastion_host add a
  # rule; the address is reduced to its network form before it reaches the
  # network module so the module always receives a canonical CIDR.
  extra_ingress = var.bastion_host == null ? {} : {
    ops_bastion = {
      description = "On-call bastion SSH"
      protocol    = "tcp"
      from_port   = 22
      to_port     = 22
      cidr_blocks = ["${cidrhost("${var.bastion_host}/${var.bastion_cidr_prefix}", 0)}/${var.bastion_cidr_prefix}"]
    }
  }
}

module "network" {
  source = "../../modules/network"

  name                 = local.name
  region               = var.region
  account_id           = var.account_id
  vpc_cidr             = var.vpc_cidr
  azs                  = var.azs
  private_subnet_cidrs = var.private_subnet_cidrs
  public_subnet_cidrs  = var.public_subnet_cidrs
  extra_ingress        = local.extra_ingress
  tags                 = local.tags
}

module "eks" {
  source = "../../modules/eks"

  name                      = local.name
  region                    = var.region
  account_id                = var.account_id
  kubernetes_version        = var.kubernetes_version
  private_subnet_ids        = module.network.private_subnet_ids
  cluster_security_group_id = module.network.cluster_security_group_id
  node_security_group_id    = module.network.node_security_group_id
  api_public_cidrs          = var.api_public_cidrs
  instance_types            = var.instance_types
  min_size                  = var.min_size
  max_size                  = var.max_size
  desired_size              = var.desired_size
  tags                      = local.tags
}

module "storage" {
  source = "../../modules/storage"

  name              = local.name
  account_id        = var.account_id
  region            = var.region
  org_id            = var.org_id
  vpce_id           = module.network.s3_endpoint_id
  media_bucket_name = var.media_bucket_name
  log_bucket_name   = var.log_bucket_name
  tags              = local.tags
}

module "iam_workload" {
  source = "../../modules/iam-workload"

  name              = local.name
  region            = var.region
  account_id        = var.account_id
  namespace         = var.portal_namespace
  oidc_provider_arn = module.eks.oidc_provider_arn
  oidc_host         = module.eks.oidc_host
  media_bucket_arn  = module.storage.media_bucket_arn
  media_kms_key_arn = module.storage.media_kms_key_arn
  node_role_arn     = module.eks.node_role_arn
  state_bucket      = var.state_bucket
  lock_table        = var.lock_table
  github_repository = var.github_repository
  tags              = local.tags
}

module "edge" {
  source = "../../modules/edge"

  name                              = local.name
  region                            = var.region
  vpc_id                            = module.network.vpc_id
  vpc_cidr                          = var.vpc_cidr
  public_subnet_ids                 = module.network.public_subnet_ids
  alb_certificate_arn               = var.alb_certificate_arn
  viewer_certificate_arn            = var.viewer_certificate_arn
  aliases                           = var.aliases
  media_bucket_regional_domain_name = module.storage.media_bucket_regional_domain_name
  log_bucket_id                     = module.storage.log_bucket_name
  tags                              = local.tags
}
