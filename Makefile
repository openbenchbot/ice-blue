ENVS := dev staging prod
K8S_VERSION := 1.31.0

.PHONY: fmt validate manifests kubeconform tflint

fmt:
	terraform fmt -recursive infra

validate:
	@for env in $(ENVS); do \
		echo "==> terraform validate $$env"; \
		terraform -chdir=infra/envs/$$env init -backend=false -input=false -no-color; \
		terraform -chdir=infra/envs/$$env validate -no-color; \
	done

manifests:
	@mkdir -p build/manifests
	@for env in $(ENVS); do \
		kubectl kustomize deploy/k8s/overlays/$$env > build/manifests/$$env.yaml; \
	done

kubeconform: manifests
	@for env in $(ENVS); do \
		echo "==> kubeconform $$env"; \
		kubeconform -strict -summary -kubernetes-version $(K8S_VERSION) build/manifests/$$env.yaml; \
	done

tflint:
	@for env in $(ENVS); do \
		echo "==> tflint $$env"; \
		tflint --chdir=infra/envs/$$env --config="$(CURDIR)/infra/.tflint.hcl"; \
	done
