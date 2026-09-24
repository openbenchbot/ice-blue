# Portal architecture

Portal is the customer-facing web application. It runs as a single stateless Deployment on EKS. Uploaded files are stored in S3 and served back through CloudFront. There is one AWS account (`123456789012`) and three isolated environments: dev, staging, and prod. Each environment has its own Terraform state, VPC, cluster, and Kustomize overlay. Nothing here is applied from a laptop.

## Request path

```
client → CloudFront (WAF) → ALB :443 → pods :3000
portal → IRSA → S3 media bucket (KMS)
```

CloudFront terminates TLS for `app.example.com` (and the dev and staging hostnames), applies the edge WAF, and forwards dynamic traffic to the ALB. The `/media/*` behavior reads from the media bucket with origin access control. Pods call AWS APIs through interface VPC endpoints. Private subnets have no internet route.

## Network

Each VPC is dual-stack-free IPv4. Public subnets only host the ALB. Worker nodes and interface endpoints live in the private subnets. The node security group allows VPC traffic required by the cluster, and environments can merge additional ingress in `extra_ingress`. The ALB security group publishes only 443.

Security groups set their own egress. Nodes may reach the VPC and the S3 prefix list on 443, plus DNS inside the VPC. The default security group is emptied.

## Cluster and identity

EKS API access is private, with a public endpoint limited to the corporate NAT (`203.0.113.10/32`). Secrets are encrypted with a customer-managed key. Control plane logs are enabled. Node IMDS requires tokens and a hop limit of 1.

The portal ServiceAccount does not mount a token in the base manifests. The workload IAM role trusts the cluster OIDC provider. Its permission policy is `s3:GetObject` on `uploads/*` and `kms:Decrypt` for the media key when the call arrives via S3.

GitHub Actions assumes a separate role. The trust is `StringEquals` on `repo:openbenchbot/ice-blue:ref:refs/heads/main`. That role can use the state bucket and pass the node role to EKS, and nothing broader.

## Data

The media bucket blocks public access, enforces bucket-owner ownership, versions objects, and defaults to the customer-managed key. A bucket policy denies non-TLS requests. CloudFront read access is assembled from the fragments in `infra/policies`. Org members can read through the STS interface endpoint when both `aws:PrincipalOrgID` and `aws:SourceVpce` match.

Access logs (ALB, CloudFront, S3 server access) go to a second bucket with the same public-access and encryption defaults.

## Delivery

Images are built from the distroless Dockerfile and are not tagged `latest`. Kubernetes manifests start in `deploy/k8s/base` (non-root, dropped capabilities, read-only root filesystem, seccomp, network policy, PDB, HPA, namespace-scoped RBAC). Overlays set the environment, replica count, and image. Prod adds the log-shipper component and its config generators. Node logs are collected by a kube-system DaemonSet; see `docs/runbooks/node-logs.md`.

## Repo map

| Path | Owns |
| --- | --- |
| `infra/modules/network` | VPC, subnets, security groups, endpoints, flow logs |
| `infra/modules/eks` | Cluster, node group, OIDC provider |
| `infra/modules/storage` | Media and log buckets, KMS, bucket policies |
| `infra/modules/iam-workload` | Portal role and CI role |
| `infra/modules/edge` | CloudFront, WAF, ALB |
| `infra/envs/<env>` | Environment composition and tfvars |
| `deploy/k8s/base` | Hardened workload manifests |
| `deploy/k8s/overlays/<env>` | Environment overlay |
