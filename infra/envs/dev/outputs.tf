output "cluster_name" {
  description = "EKS cluster name."
  value       = module.eks.cluster_name
}

output "app_role_arn" {
  description = "IAM role assumed by the portal ServiceAccount."
  value       = module.iam_workload.app_role_arn
}

output "ci_role_arn" {
  description = "IAM role assumed by GitHub Actions."
  value       = module.iam_workload.ci_role_arn
}

output "media_bucket_name" {
  description = "Media bucket name."
  value       = module.storage.media_bucket_name
}

output "distribution_domain_name" {
  description = "CloudFront distribution domain name."
  value       = module.edge.distribution_domain_name
}

output "alb_dns_name" {
  description = "ALB DNS name."
  value       = module.edge.alb_dns_name
}
