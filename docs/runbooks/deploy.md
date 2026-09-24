# Deploy

Plans and applies run in GitHub Actions on `main`, as `openbenchbot/ice-blue`. The workflow assumes `portal-ci` with GitHub OIDC. Do not put access keys in the environment.

## Before a pull request

```bash
make fmt
make validate
make kubeconform
```

`make validate` initialises each environment with `-backend=false`. It does not read state and it does not call AWS.

## Plan

`terraform-plan` runs `terraform plan` for the environment whose files changed. Prod plans need the `prod` environment approval. Read the plan. Module diffs and tfvars both show up; check both.

State buckets and the lock table already exist and are not managed by these roots:

| Environment | State bucket | Key |
| --- | --- | --- |
| dev | `example-com-portal-tfstate-dev` | `portal/dev/terraform.tfstate` |
| staging | `example-com-portal-tfstate-staging` | `portal/staging/terraform.tfstate` |
| prod | `example-com-portal-tfstate-prod` | `portal/prod/terraform.tfstate` |

## Release

Merging to `main` builds the image and applies the overlay that matches the environment being released.

```bash
kubectl kustomize deploy/k8s/overlays/prod
kubectl apply -k deploy/k8s/overlays/prod
```

The apply is the workflow's job. The base is not applied on its own; overlays are the deployable unit. Prod includes components and generators that dev and staging do not.

## Rollback

Re-run the previous workflow commit. Avoid editing live objects. Terraform state is versioned with the bucket, so a revert is a normal plan.
