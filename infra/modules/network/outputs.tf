output "vpc_id" {
  description = "VPC id."
  value       = aws_vpc.this.id
}

output "private_subnet_ids" {
  description = "Private subnet ids."
  value       = [for subnet in aws_subnet.private : subnet.id]
}

output "public_subnet_ids" {
  description = "Public subnet ids."
  value       = [for subnet in aws_subnet.public : subnet.id]
}

output "cluster_security_group_id" {
  description = "Security group attached to the EKS control plane."
  value       = aws_security_group.cluster.id
}

output "node_security_group_id" {
  description = "Security group attached to worker nodes."
  value       = aws_security_group.nodes.id
}

output "s3_endpoint_id" {
  description = "Gateway VPC endpoint used for S3."
  value       = aws_vpc_endpoint.s3.id
}
