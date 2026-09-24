# Portal

Customer portal and the infrastructure that runs it. The app is a Next.js service. Each environment is a separate Terraform root under `infra/envs`, deployed onto its own EKS cluster with the Kustomize overlay in `deploy/k8s/overlays`.

## Layout

- `src` — application
- `infra/modules` — network, cluster, storage, workload identity, edge
- `infra/envs` — dev, staging, prod
- `infra/policies` — bucket policy fragments
- `deploy/k8s` — base manifests and per-environment overlays
- `docs` — architecture and runbooks

## App

```bash
npm ci
npm run dev
```

`GET /api/health` is the process and load balancer probe. `POST /api/uploads` accepts a single `file` field (PNG, JPEG, or PDF, up to 10MB) and returns an id. Object storage is handled by the platform, not by the process.

The container image is built from the multi-stage `Dockerfile` (`npm run build` with `output: "standalone"`, then a distroless non-root runtime).

## Infrastructure

Terraform is split by environment so a plan in dev cannot touch prod state. See `docs/architecture.md` and `docs/runbooks/deploy.md`.

```bash
make fmt
make validate
make kubeconform
```
