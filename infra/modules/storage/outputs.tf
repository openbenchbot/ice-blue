output "media_bucket_name" {
  description = "Media bucket name."
  value       = aws_s3_bucket.media.id
}

output "media_bucket_arn" {
  description = "Media bucket ARN."
  value       = aws_s3_bucket.media.arn
}

output "media_bucket_regional_domain_name" {
  description = "Regional domain name of the media bucket."
  value       = aws_s3_bucket.media.bucket_regional_domain_name
}

output "media_kms_key_arn" {
  description = "KMS key used by the media bucket."
  value       = aws_kms_key.media.arn
}

output "log_bucket_name" {
  description = "Access log bucket name."
  value       = aws_s3_bucket.logs.id
}

output "log_bucket_domain_name" {
  description = "Domain name of the access log bucket."
  value       = aws_s3_bucket.logs.bucket_domain_name
}
