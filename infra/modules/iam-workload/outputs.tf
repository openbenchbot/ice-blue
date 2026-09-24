output "app_role_arn" {
  description = "IAM role assumed by the portal ServiceAccount."
  value       = aws_iam_role.app.arn
}

output "ci_role_arn" {
  description = "IAM role assumed by GitHub Actions."
  value       = aws_iam_role.ci.arn
}
