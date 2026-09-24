output "cluster_name" {
  description = "EKS cluster name."
  value       = aws_eks_cluster.this.name
}

output "oidc_provider_arn" {
  description = "IAM OIDC provider ARN for the cluster."
  value       = aws_iam_openid_connect_provider.this.arn
}

output "oidc_host" {
  description = "OIDC issuer host, without the https scheme."
  value       = replace(aws_iam_openid_connect_provider.this.url, "https://", "")
}

output "node_role_arn" {
  description = "IAM role used by worker nodes."
  value       = aws_iam_role.nodes.arn
}
