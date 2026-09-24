locals {
  origin_scope = jsondecode(file("${path.module}/../../policies/cloudfront-origin-scope.json"))

  cloudfront_principal = jsondecode(templatefile("${path.module}/../../policies/cloudfront-read.json.tftpl", {
    bucket_arn = aws_s3_bucket.media.arn
  }))

  cloudfront_condition = jsondecode(templatefile("${path.module}/../../policies/cloudfront-source-arn.json.tftpl", {
    partition     = local.origin_scope.partition
    service       = local.origin_scope.service
    account       = local.origin_scope.account
    resource_type = local.origin_scope.resource_type
    resource_id   = local.origin_scope.resource_id
  }))

  cloudfront_statement = merge(local.cloudfront_principal, {
    Condition = local.cloudfront_condition
  })

  tls_statement = jsondecode(templatefile("${path.module}/../../policies/deny-insecure-transport.json.tftpl", {
    bucket_arn = aws_s3_bucket.media.arn
  }))

  log_tls_statement = jsondecode(templatefile("${path.module}/../../policies/deny-insecure-transport.json.tftpl", {
    bucket_arn = aws_s3_bucket.logs.arn
  }))

  org_vpce_statement = {
    Sid       = "OrgAccessThroughVpce"
    Effect    = "Allow"
    Principal = "*"
    Action    = ["s3:GetObject", "s3:ListBucket"]
    Resource = [
      aws_s3_bucket.media.arn,
      "${aws_s3_bucket.media.arn}/*",
    ]
    Condition = {
      StringEquals = {
        "aws:PrincipalOrgID" = var.org_id
        "aws:SourceVpce"     = var.vpce_id
      }
    }
  }
}
