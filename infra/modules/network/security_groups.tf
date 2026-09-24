resource "aws_security_group" "nodes" {
  name        = "${var.name}-nodes"
  description = "EKS worker nodes"
  vpc_id      = aws_vpc.this.id

  dynamic "ingress" {
    for_each = local.ingress_rules

    content {
      description = ingress.value.description
      protocol    = ingress.value.protocol
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  ingress {
    description = "Kubelet from the control plane"
    protocol    = "tcp"
    from_port   = 10250
    to_port     = 10250
    cidr_blocks = [var.vpc_cidr]
  }

  egress {
    description = "HTTPS to interface endpoints in the VPC"
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
    cidr_blocks = [var.vpc_cidr]
  }

  egress {
    description     = "HTTPS to S3 through the gateway endpoint"
    protocol        = "tcp"
    from_port       = 443
    to_port         = 443
    prefix_list_ids = [data.aws_prefix_list.s3.id]
  }

  egress {
    description = "DNS in the VPC"
    protocol    = "udp"
    from_port   = 53
    to_port     = 53
    cidr_blocks = [var.vpc_cidr]
  }

  egress {
    description = "DNS in the VPC"
    protocol    = "tcp"
    from_port   = 53
    to_port     = 53
    cidr_blocks = [var.vpc_cidr]
  }

  tags = merge(var.tags, {
    Name = "${var.name}-nodes"
  })
}

resource "aws_security_group" "cluster" {
  name        = "${var.name}-cluster"
  description = "EKS control plane"
  vpc_id      = aws_vpc.this.id

  ingress {
    description     = "API from worker nodes"
    protocol        = "tcp"
    from_port       = 443
    to_port         = 443
    security_groups = [aws_security_group.nodes.id]
  }

  egress {
    description     = "Kubelet to worker nodes"
    protocol        = "tcp"
    from_port       = 10250
    to_port         = 10250
    security_groups = [aws_security_group.nodes.id]
  }

  tags = merge(var.tags, {
    Name = "${var.name}-cluster"
  })
}

resource "aws_security_group" "endpoints" {
  name        = "${var.name}-endpoints"
  description = "Interface VPC endpoints"
  vpc_id      = aws_vpc.this.id

  ingress {
    description = "HTTPS from the VPC"
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
    cidr_blocks = [var.vpc_cidr]
  }

  egress {
    description = "HTTPS responses stay in the VPC"
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
    cidr_blocks = [var.vpc_cidr]
  }

  tags = merge(var.tags, {
    Name = "${var.name}-endpoints"
  })
}
