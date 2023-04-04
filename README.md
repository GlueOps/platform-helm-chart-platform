# glueops-platform

![Version: 0.3.0](https://img.shields.io/badge/Version-0.3.0-informational?style=flat-square) ![AppVersion: v0.1.0](https://img.shields.io/badge/AppVersion-v0.1.0-informational?style=flat-square)

This chart deploys the GlueOps Platform

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| captain_domain | string | `"<cluster_env>.<tenant-name-goes-here>.onglueops.rocks"` | The Route53 subdomain for the services on your cluster. It will be used as the suffix url for argocd, grafana, vault, and any other services that come out of the box in the glueops platform. Note: you need to create this before using this repo as this repo does not provision DNS Zones for you. This is the domain you created through: https://github.com/GlueOps/terraform-module-cloud-multy-prerequisites |
| certManager.aws_accessKey | string | `"XXXXXXXXXXXXXXXXXXXXXXXXXX"` | Part of `certmanager_iam_credentials` output from terraform-module-cloud-multy-prerequisites: https://github.com/GlueOps/terraform-module-cloud-multy-prerequisites |
| certManager.aws_region | string | `"us-west-2"` | Should be the same `primary_region` you used in: https://github.com/GlueOps/terraform-module-cloud-multy-prerequisites |
| certManager.aws_secretKey | string | `"XXXXXXXXXXXXXXXXXXXXXXXXXX"` | Part of `certmanager_iam_credentials` output from terraform-module-cloud-multy-prerequisites: https://github.com/GlueOps/terraform-module-cloud-multy-prerequisites |
| dex.argocd.client_secret | string | `"XXXXXXXXXXXXXXXXXXXXXXXXXX"` | Specify a unique password here. This will be used to connect argocd via OIDC to the Dex IDP. You can create one with in bash `openssl rand -base64 32` |
| dex.github.client_id | string | `"XXXXXXXXXXXXXXXXXXXXXXXXXX"` | To create a clientID please reference: https://github.com/GlueOps/github-oauth-apps/tree/v0.0.1 |
| dex.github.client_secret | string | `"XXXXXXXXXXXXXXXXXXXXXXXXXX"` | To create a clientSecret please reference: https://github.com/GlueOps/github-oauth-apps/tree/v0.0.1 |
| dex.github.orgs | list | `["GlueOps","glueops-rocks"]` | Specify the github orgs you want to allow access to. This is a list of strings. Note: users still need to be in the proper groups to have access. |
| dex.grafana.client_secret | string | `"XXXXXXXXXXXXXXXXXXXXXXXXXX"` | Specify a unique password here. This will be used to connect grafana via OAuth to the Dex IDP. You can create one with in bash `openssl rand -base64 32` |
| dex.pomerium.client_secret | string | `"XXXXXXXXXXXXXXXXXXXXXXXXXX"` | Specify a unique password here. This will be used to connect argocd via OIDC to the Dex IDP. You can create one with in bash `openssl rand -base64 32` |
| externalDns.aws_accessKey | string | `"XXXXXXXXXXXXXXXXXXXXXXXXXX"` | Part of `externaldns_iam_credentials` output from terraform-module-cloud-multy-prerequisites: https://github.com/GlueOps/terraform-module-cloud-multy-prerequisites |
| externalDns.aws_region | string | `"us-west-2"` | Should be the same `primary_region` you used in: https://github.com/GlueOps/terraform-module-cloud-multy-prerequisites |
| externalDns.aws_secretKey | string | `"XXXXXXXXXXXXXXXXXXXXXXXXXX"` | Part of `externaldns_iam_credentials` output from terraform-module-cloud-multy-prerequisites: https://github.com/GlueOps/terraform-module-cloud-multy-prerequisites |
| gitHub.api_token | string | `"XXXXXXXXXXXXXXXXXXXXXXXXXX"` | create a Personal Access Token in github that has repo scope access. It would be best to use a service account for this otherwise all the comments on PR will be left in your name |
| gitHub.customer_github_org_and_team | string | `"glueops-rocks:developers"` | The format is: <github-org-name>:<github-team-name> (The team should include the developers) |
| gitHub.tenant_application_stack_repo | string | `"git@github.com:<your-org-name>/<your-repo-name>.git"` | This is the repo that will be used to store all the tenant's cluster applications. The developers will have access to this repo and will be able to create PRs to this repo. The repo should be private.  |
| gitHub.tenant_b64enc_ssh_private_key | string | `"XXXXXXXXXXXXXXXXXXXXXXXXXX"` | Create a deploy key to access the application stack repository it and format using `cat <key-file> | base64 | tr -d '\n'`. ref: https://docs.github.com/en/authentication/connecting-to-github-with-ssh/managing-deploy-keys#deploy-keys |
| glueops_alerts.opsgenie_apikey | string | `"nil"` | Part of `opsgenie_prometheus_api_keys` output from terraform-module-cloud-multy-prerequisites: https://github.com/GlueOps/terraform-module-cloud-multy-prerequisites |
| glueops_backups.vault.aws_accessKey | string | `"XXXXXXXXXXXXXXXXXXXXXXXXXX"` | Part of `vault_s3_iam_credentials` output from terraform-module-cloud-multy-prerequisites: https://github.com/GlueOps/terraform-module-cloud-multy-prerequisites |
| glueops_backups.vault.aws_region | string | `"us-west-2"` | Should be the same `primary_region` you used in: https://github.com/GlueOps/terraform-module-cloud-multy-prerequisites |
| glueops_backups.vault.aws_secretKey | string | `"XXXXXXXXXXXXXXXXXXXXXXXXXX"` | Part of `vault_s3_iam_credentials` output from terraform-module-cloud-multy-prerequisites: https://github.com/GlueOps/terraform-module-cloud-multy-prerequisites |
| glueops_backups.vault.company_key | string | `"<tenant-name-goes-here>"` |  |
| grafana.admin_password | string | `"glueops-is-awesome"` | Default admin password. CHANGE THIS!!!! |
| grafana.github_other_org_names | string | `"glueops-rocks"` |  |
| loki.aws_accessKey | string | `"XXXXXXXXXXXXXXXXXXXXXXXXXX"` | Part of `loki_s3_iam_credentials` output from terraform-module-cloud-multy-prerequisites: https://github.com/GlueOps/terraform-module-cloud-multy-prerequisites |
| loki.aws_region | string | `"us-west-2"` | Should be the same `primary_region` you used in: https://github.com/GlueOps/terraform-module-cloud-multy-prerequisites |
| loki.aws_secretKey | string | `"XXXXXXXXXXXXXXXXXXXXXXXXXX"` | Part of `loki_s3_iam_credentials` output from terraform-module-cloud-multy-prerequisites: https://github.com/GlueOps/terraform-module-cloud-multy-prerequisites |
| loki.bucket | string | `"glueops-tenant-<tenant-name-goes-here>-<cluster_env>-loki-primary"` | Format: glueops-tenant-<tenant-name-goes-here>-<cluster_env>-loki-primary |
