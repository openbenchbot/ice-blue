# Break-glass node access

Prod can add ingress to the node security group without changing the network module. Put the rule in `extra_ingress` in `infra/envs/prod/terraform.tfvars`. The module merges that map with its defaults. Dev and staging do not set it.

The current prod rule is `ops_bastion`, tcp/22, for the on-call bastion. Removing the key and applying the prod root withdraws the rule. Do not add the rule to the module defaults; an environment that does not need it should not inherit it.

Access is time-bounded. Open a ticket before the change and link the plan. The bastion is operated by the platform on-call rotation, not by application developers.
