# glueops-platform

![Version: 0.12.0](https://img.shields.io/badge/Version-0.12.0-informational?style=flat-square) ![AppVersion: v0.1.0](https://img.shields.io/badge/AppVersion-v0.1.0-informational?style=flat-square)

This chart deploys the GlueOps Platform

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| captain_domain | string | `"placeholder_cluster_environment.placeholder_tenant_key.placeholder_glueops_root_domain"` | The Route53 subdomain for the services on your cluster. It will be used as the suffix url for argocd, grafana, vault, and any other services that come out of the box in the glueops platform. Note: you need to create this before using this repo as this repo does not provision DNS Zones for you. This is the domain you created through: https://github.com/GlueOps/terraform-module-cloud-multy-prerequisites |
| certManager.aws_accessKey | string | `"placeholder_certmanager_aws_access_key"` | Part of `certmanager_iam_credentials` output from terraform-module-cloud-multy-prerequisites: https://github.com/GlueOps/terraform-module-cloud-multy-prerequisites |
| certManager.aws_region | string | `"placeholder_aws_region"` | Should be the same `primary_region` you used in: https://github.com/GlueOps/terraform-module-cloud-multy-prerequisites |
| certManager.aws_secretKey | string | `"placeholder_certmanager_aws_secret_key"` | Part of `certmanager_iam_credentials` output from terraform-module-cloud-multy-prerequisites: https://github.com/GlueOps/terraform-module-cloud-multy-prerequisites |
| dex.argocd.client_secret | string | `"placeholder_dex_argocd_client_secret"` | Specify a unique password here. This will be used to connect argocd via OIDC to the Dex IDP. You can create one with in bash `openssl rand -base64 32` |
| dex.github.client_id | string | `"placeholder_dex_github_client_id"` | To create a clientID please reference: https://github.com/GlueOps/github-oauth-apps/tree/v0.0.1 |
| dex.github.client_secret | string | `"placeholder_dex_github_client_secret"` | To create a clientSecret please reference: https://github.com/GlueOps/github-oauth-apps/tree/v0.0.1 |
| dex.github.orgs | list | `["placeholder_admin_github_org_name","placeholder_tenant_github_org_name"]` | Specify the github orgs you want to allow access to. This is a list of strings. Note: users still need to be in the proper groups to have access. |
| dex.grafana.client_secret | string | `"placeholder_dex_grafana_client_secret"` | Specify a unique password here. This will be used to connect grafana via OAuth to the Dex IDP. You can create one with in bash `openssl rand -base64 32` |
| dex.pomerium.client_secret | string | `"placeholder_dex_pomerium_client_secret"` | Specify a unique password here. This will be used to connect argocd via OIDC to the Dex IDP. You can create one with in bash `openssl rand -base64 32` |
| dex.vault.client_secret | string | `"placeholder_dex_vault_client_secret"` |  |
| externalDns.aws_accessKey | string | `"placeholder_externaldns_aws_access_key"` | Part of `externaldns_iam_credentials` output from terraform-module-cloud-multy-prerequisites: https://github.com/GlueOps/terraform-module-cloud-multy-prerequisites |
| externalDns.aws_region | string | `"placeholder_aws_region"` | Should be the same `primary_region` you used in: https://github.com/GlueOps/terraform-module-cloud-multy-prerequisites |
| externalDns.aws_secretKey | string | `"placeholder_externaldns_aws_secret_key"` | Part of `externaldns_iam_credentials` output from terraform-module-cloud-multy-prerequisites: https://github.com/GlueOps/terraform-module-cloud-multy-prerequisites |
| gitHub.api_token | string | `"placeholder_github_api_token"` | create a Personal Access Token in github that has repo scope access. It would be best to use a service account for this otherwise all the comments on PR will be left in your name |
| gitHub.customer_github_org_and_team | string | `"placeholder_tenant_github_org_name:developers"` | The format is: <github-org-name>:<github-team-name> (The team should include the developers) |
| gitHub.tenant_application_stack_repo | string | `"git@github.com:placeholder_tenant_github_org_name/glueops-placeholder_tenant_key-placeholder_cluster_environment-stack.git"` | This is the repo that will be used to store all the tenant's cluster applications. The developers will have access to this repo and will be able to create PRs to this repo. The repo should be private.  |
| gitHub.tenant_b64enc_ssh_private_key | string | `"placeholder_tenant_b64enc_ssh_private_key"` | Create a deploy key to access the application stack repository it and format using `cat <key-file> | base64 | tr -d '\n'`. ref: https://docs.github.com/en/authentication/connecting-to-github-with-ssh/managing-deploy-keys#deploy-keys |
| glueops_alerts.opsgenie_apikey | string | `"placeholder_opsgenie_api_key"` | Found at `opsgenie_credentials` in the json output that is part of `opsgenie_prometheus_api_keys` output from terraform-module-cloud-multy-prerequisites: https://github.com/GlueOps/terraform-module-cloud-multy-prerequisites |
| glueops_backups.loki_exporter_to_s3.aws_accessKey | string | `"placeholder_loki_exporter_aws_access_key"` | Part of `loki_log_exporter` output from terraform-module-cloud-multy-prerequisites: https://github.com/GlueOps/terraform-module-cloud-multy-prerequisites |
| glueops_backups.loki_exporter_to_s3.aws_region | string | `"placeholder_aws_region"` | Should be the same `primary_region` you used in: https://github.com/GlueOps/terraform-module-cloud-multy-prerequisites |
| glueops_backups.loki_exporter_to_s3.aws_secretKey | string | `"placeholder_loki_exporter_aws_secret_key"` | Part of `loki_log_exporter` output from terraform-module-cloud-multy-prerequisites: https://github.com/GlueOps/terraform-module-cloud-multy-prerequisites |
| glueops_backups.loki_exporter_to_s3.company_key | string | `"placeholder_tenant_key"` |  |
| glueops_backups.vault.aws_accessKey | string | `"placeholder_vault_aws_access_key"` | Part of `vault_s3_iam_credentials` output from terraform-module-cloud-multy-prerequisites: https://github.com/GlueOps/terraform-module-cloud-multy-prerequisites |
| glueops_backups.vault.aws_region | string | `"placeholder_aws_region"` | Should be the same `primary_region` you used in: https://github.com/GlueOps/terraform-module-cloud-multy-prerequisites |
| glueops_backups.vault.aws_secretKey | string | `"placeholder_vault_aws_secret_key"` | Part of `vault_s3_iam_credentials` output from terraform-module-cloud-multy-prerequisites: https://github.com/GlueOps/terraform-module-cloud-multy-prerequisites |
| glueops_backups.vault.company_key | string | `"placeholder_tenant_key"` |  |
| grafana.admin_password | string | `"placeholder_grafana_admin_password"` | Default admin password. CHANGE THIS!!!! |
| grafana.github_other_org_names | string | `"placeholder_tenant_github_org_name"` |  |
| loki.aws_accessKey | string | `"placeholder_loki_aws_access_key"` | Part of `loki_s3_iam_credentials` output from terraform-module-cloud-multy-prerequisites: https://github.com/GlueOps/terraform-module-cloud-multy-prerequisites |
| loki.aws_region | string | `"placeholder_aws_region"` | Should be the same `primary_region` you used in: https://github.com/GlueOps/terraform-module-cloud-multy-prerequisites |
| loki.aws_secretKey | string | `"placeholder_loki_aws_secret_key"` | Part of `loki_s3_iam_credentials` output from terraform-module-cloud-multy-prerequisites: https://github.com/GlueOps/terraform-module-cloud-multy-prerequisites |
| loki.bucket | string | `"glueops-tenant-placeholder_tenant_key-placeholder_cluster_environment-loki-primary"` | Format: glueops-tenant-placeholder_tenant_key-placeholder_cluster_environment-loki-primary, Credentials found at `loki_credentials` of json output of terraform-module-cloud-multy-prerequisites |
| prometheus.volume_claim_storage_request | string | `"50"` | Volume of storage requested for each Prometheus PVC, in Gi |
