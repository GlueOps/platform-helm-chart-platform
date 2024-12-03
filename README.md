# glueops-platform

![Version: 0.53.0](https://img.shields.io/badge/Version-0.53.0-informational?style=flat-square) ![AppVersion: v0.1.0](https://img.shields.io/badge/AppVersion-v0.1.0-informational?style=flat-square)

This chart deploys the GlueOps Platform

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| captain_domain | string | `"placeholder_cluster_environment.placeholder_tenant_key.placeholder_glueops_root_domain"` | The Route53 subdomain for the services on your cluster. It will be used as the suffix url for argocd, grafana, vault, and any other services that come out of the box in the glueops platform. Note: you need to create this before using this repo as this repo does not provision DNS Zones for you. This is the domain you created through: https://github.com/GlueOps/terraform-module-cloud-multy-prerequisites |
| captain_repo.private_b64enc_deploy_key | string | `"placeholder_captain_repo_b64enc_private_deploy_key"` | This is a read only deploy key that will be used to read the captain repo. Part of output from terraform-module-cloud-multy-prerequisites: https://github.com/GlueOps/terraform-module-cloud-multy-prerequisites |
| captain_repo.ssh_clone_url | string | `"placeholder_captain_repo_ssh_clone_url"` | This is the github url of the captain repo https://github.com/glueops/development-captains/tenant . Part of output from terraform-module-cloud-multy-prerequisites: https://github.com/GlueOps/terraform-module-cloud-multy-prerequisites |
| certManager.aws_accessKey | string | `"placeholder_certmanager_aws_access_key"` | Part of `certmanager_iam_credentials` output from terraform-module-cloud-multy-prerequisites: https://github.com/GlueOps/terraform-module-cloud-multy-prerequisites |
| certManager.aws_region | string | `"placeholder_aws_region"` | Should be the same `primary_region` you used in: https://github.com/GlueOps/terraform-module-cloud-multy-prerequisites |
| certManager.aws_secretKey | string | `"placeholder_certmanager_aws_secret_key"` | Part of `certmanager_iam_credentials` output from terraform-module-cloud-multy-prerequisites: https://github.com/GlueOps/terraform-module-cloud-multy-prerequisites |
| container_images.app_backup_and_exports.backup_tools.image.registry | string | `"ghcr.io"` |  |
| container_images.app_backup_and_exports.backup_tools.image.repository | string | `"glueops/backup-tools"` |  |
| container_images.app_backup_and_exports.backup_tools.image.tag | string | `"v0.17.0@sha256:796414df217590b1196e1cd16af041fbe07fdd19f1e43f4a0752fff8e30b0009"` |  |
| container_images.app_backup_and_exports.certs_backup_restore.image.registry | string | `"ghcr.io"` |  |
| container_images.app_backup_and_exports.certs_backup_restore.image.repository | string | `"glueops/certs-backup-restore"` |  |
| container_images.app_backup_and_exports.certs_backup_restore.image.tag | string | `"v0.9.0@sha256:c91d7483d51606bba74f122087c4dc66147d882fba1c913355703a350750f526"` |  |
| container_images.app_backup_and_exports.vault_backup_validator.image.registry | string | `"ghcr.io"` |  |
| container_images.app_backup_and_exports.vault_backup_validator.image.repository | string | `"glueops/vault-backup-validator"` |  |
| container_images.app_backup_and_exports.vault_backup_validator.image.tag | string | `"v0.3.2@sha256:e4a020fa1666fdcd800185b65eacae79a206fd179b829140bd38cec4d93f28fb"` |  |
| container_images.app_cluster_info_page.cluster_information_help_page_html.image.registry | string | `"ghcr.io"` |  |
| container_images.app_cluster_info_page.cluster_information_help_page_html.image.repository | string | `"glueops/cluster-information-help-page-html"` |  |
| container_images.app_cluster_info_page.cluster_information_help_page_html.image.tag | string | `"v0.4.4@sha256:5c9a0cf36c3539a2076c654b3c2e253cc3f131c93395acb293f6ffb4ef053baf"` |  |
| container_images.app_dex.dex.image.registry | string | `"ghcr.io"` |  |
| container_images.app_dex.dex.image.repository | string | `"dexidp/dex"` |  |
| container_images.app_dex.dex.image.tag | string | `"v2.41.1@sha256:bc7cfce7c17f52864e2bb2a4dc1d2f86a41e3019f6d42e81d92a301fad0c8a1d"` |  |
| container_images.app_fluent_operator.image.registry | string | `"docker.io"` |  |
| container_images.app_fluent_operator.image.repository | string | `"kubesphere/fluent-operator"` |  |
| container_images.app_fluent_operator.image.tag | string | `"v2.7.0@sha256:b0668c0d878bde4ab04802a7e92d0dd3bef4c1fed1b5e63cf83d49bb3c5d3947"` |  |
| container_images.app_glueops_alerts.cluster_monitoring.image.registry | string | `"ghcr.io"` |  |
| container_images.app_glueops_alerts.cluster_monitoring.image.repository | string | `"glueops/cluster-monitoring"` |  |
| container_images.app_glueops_alerts.cluster_monitoring.image.tag | string | `"v0.7.0@sha256:1251bc27411647297d0867c13c56c2347a00dd44b6a06b1fdd6fd08f094e2934"` |  |
| container_images.app_ingress_nginx.controller.image.registry | string | `"registry.k8s.io"` |  |
| container_images.app_ingress_nginx.controller.image.repository | string | `"ingress-nginx/controller"` |  |
| container_images.app_ingress_nginx.controller.image.tag | string | `"v1.11.3@sha256:d56f135b6462cfc476447cfe564b83a45e8bb7da2774963b00d12161112270b7"` |  |
| container_images.app_kube_prometheus_stack.grafana.image.registry | string | `"docker.io"` |  |
| container_images.app_kube_prometheus_stack.grafana.image.repository | string | `"grafana/grafana"` |  |
| container_images.app_kube_prometheus_stack.grafana.image.tag | string | `"10.4.13@sha256:c8644d0d41757dd444bd1aabc23740be71f0a34549128454a2b37f57a0c496b0"` |  |
| container_images.app_loki.loki.image.registry | string | `"docker.io"` |  |
| container_images.app_loki.loki.image.repository | string | `"grafana/loki"` |  |
| container_images.app_loki.loki.image.tag | string | `"2.9.10@sha256:35b02acc67654ddc38273e519b4f26f3967a907b9db5489af300c21f37ee1ae7"` |  |
| container_images.app_loki_alert_group_controller.loki_alert_group_controller.image.registry | string | `"ghcr.io"` |  |
| container_images.app_loki_alert_group_controller.loki_alert_group_controller.image.repository | string | `"glueops/metacontroller-operator-loki-rule-group"` |  |
| container_images.app_loki_alert_group_controller.loki_alert_group_controller.image.tag | string | `"v0.4.5@sha256:44b60d68a836eb91475d12385f1ac97e4d329abcefe2c915da9774db46f4cbdf"` |  |
| container_images.app_metacontroller.metacontroller.image.registry | string | `"ghcr.io"` |  |
| container_images.app_metacontroller.metacontroller.image.repository | string | `"metacontroller/metacontroller"` |  |
| container_images.app_metacontroller.metacontroller.image.tag | string | `"v4.11.21@sha256:4cbf35c1c725b2c83b926d9ade1e282bf789bf4453f23fe2f1b055b781a6798c"` |  |
| container_images.app_network_exporter.network_exporter.image.registry | string | `"docker.io"` |  |
| container_images.app_network_exporter.network_exporter.image.repository | string | `"syepes/network_exporter"` |  |
| container_images.app_network_exporter.network_exporter.image.tag | string | `"1.7.9@sha256:36cd647c80c30e3f5b78f9d2ca60f38e1d024fb3b9588a845cac2dc3f4fb75e1"` |  |
| container_images.app_promtail.promtail.image.registry | string | `"docker.io"` |  |
| container_images.app_promtail.promtail.image.repository | string | `"grafana/promtail"` |  |
| container_images.app_promtail.promtail.image.tag | string | `"2.9.10@sha256:63a2e57a5b1401109f77d36a49a637889d431280ed38f5f885eedcd3949e52cf"` |  |
| container_images.app_pull_request_bot.pull_request_bot.image.registry | string | `"ghcr.io"` |  |
| container_images.app_pull_request_bot.pull_request_bot.image.repository | string | `"glueops/pull-request-bot"` |  |
| container_images.app_pull_request_bot.pull_request_bot.image.tag | string | `"v0.21.0@sha256:bb58a912192bc5bd531320d60a099fbe0906cf64bd31fd374b5404c748d427ee"` |  |
| container_images.app_qr_code_generator.qr_code_generator.image.registry | string | `"ghcr.io"` |  |
| container_images.app_qr_code_generator.qr_code_generator.image.repository | string | `"glueops/qr-code-generator"` |  |
| container_images.app_qr_code_generator.qr_code_generator.image.tag | string | `"v0.6.0@sha256:820af4855a897de73d39bdcfb8c5eef69a25bcfb6561048aac235b0db9615a66"` |  |
| container_images.app_vault.vault.image.registry | string | `"docker.io"` |  |
| container_images.app_vault.vault.image.repository | string | `"hashicorp/vault"` |  |
| container_images.app_vault.vault.image.tag | string | `"1.14.10@sha256:14be0a8eb323181a56d10facab3b424809d9921e85d2f2678126ce232766a8e1"` |  |
| container_images.app_vault_init_controller.vault_init_controller.image.registry | string | `"ghcr.io"` |  |
| container_images.app_vault_init_controller.vault_init_controller.image.repository | string | `"glueops/vault-init-controller"` |  |
| container_images.app_vault_init_controller.vault_init_controller.image.tag | string | `"v0.7.0@sha256:4b217fd3961e02a704394fb02380d2b77983bab82a1d3b4082e436c9f175f583"` |  |
| daemonset_tolerations[0].effect | string | `"NoSchedule"` |  |
| daemonset_tolerations[0].operator | string | `"Exists"` |  |
| daemonset_tolerations[1].effect | string | `"NoExecute"` |  |
| daemonset_tolerations[1].key | string | `"node.kubernetes.io/not-ready"` |  |
| daemonset_tolerations[1].operator | string | `"Exists"` |  |
| daemonset_tolerations[2].effect | string | `"NoExecute"` |  |
| daemonset_tolerations[2].key | string | `"node.kubernetes.io/unreachable"` |  |
| daemonset_tolerations[2].operator | string | `"Exists"` |  |
| daemonset_tolerations[3].effect | string | `"NoSchedule"` |  |
| daemonset_tolerations[3].key | string | `"node.kubernetes.io/disk-pressure"` |  |
| daemonset_tolerations[3].operator | string | `"Exists"` |  |
| daemonset_tolerations[4].effect | string | `"NoSchedule"` |  |
| daemonset_tolerations[4].key | string | `"node.kubernetes.io/memory-pressure"` |  |
| daemonset_tolerations[4].operator | string | `"Exists"` |  |
| daemonset_tolerations[5].effect | string | `"NoSchedule"` |  |
| daemonset_tolerations[5].key | string | `"node.kubernetes.io/pid-pressure"` |  |
| daemonset_tolerations[5].operator | string | `"Exists"` |  |
| daemonset_tolerations[6].effect | string | `"NoSchedule"` |  |
| daemonset_tolerations[6].key | string | `"node.kubernetes.io/unschedulable"` |  |
| daemonset_tolerations[6].operator | string | `"Exists"` |  |
| daemonset_tolerations[7].effect | string | `"NoSchedule"` |  |
| daemonset_tolerations[7].key | string | `"node.kubernetes.io/network-unavailable"` |  |
| daemonset_tolerations[7].operator | string | `"Exists"` |  |
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
| gitHub.github_app_b64enc_private_key | string | `"placeholder_github_tenant_app_b64enc_private_key"` |  |
| gitHub.github_app_id | string | `"placeholder_github_tenant_app_id"` | Create an Application in the tenant's github organization that has repo scope access and can comment against PRs. https://docs.github.com/en/apps/creating-github-apps/setting-up-a-github-app/creating-a-github-app.  Format the key using format using `cat <key-file> | base64 | tr -d '\n'` |
| gitHub.github_app_installation_id | string | `"placeholder_github_tenant_app_installation_id"` |  |
| gitHub.tenant_github_org | string | `"placeholder_tenant_github_org_name"` |  |
| gitHub.tenant_github_org_and_team | string | `"placeholder_tenant_github_org_name:developers"` | The format is: <github-org-name>:<github-team-name> (The team should include the developers) |
| glueops_alerts.opsgenie_apikey | string | `"placeholder_opsgenie_api_key"` | Found at `opsgenie_credentials` in the json output that is part of `opsgenie_prometheus_api_keys` output from terraform-module-cloud-multy-prerequisites: https://github.com/GlueOps/terraform-module-cloud-multy-prerequisites |
| glueops_backups.s3_bucket_name | string | `"glueops-tenant-placeholder_tenant_key-primary"` |  |
| glueops_backups.tls_cert_backup.aws_accessKey | string | `"placeholder_tls_cert_backup_aws_access_key"` | Part of `loki_log_exporter` output from terraform-module-cloud-multy-prerequisites: https://github.com/GlueOps/terraform-module-cloud-multy-prerequisites |
| glueops_backups.tls_cert_backup.aws_region | string | `"placeholder_aws_region"` | Should be the same `primary_region` you used in: https://github.com/GlueOps/terraform-module-cloud-multy-prerequisites |
| glueops_backups.tls_cert_backup.aws_secretKey | string | `"placeholder_tls_cert_backup_aws_secret_key"` | Part of `loki_log_exporter` output from terraform-module-cloud-multy-prerequisites: https://github.com/GlueOps/terraform-module-cloud-multy-prerequisites |
| glueops_backups.tls_cert_backup.backup_prefix | string | `"placeholder_tls_cert_backup_s3_key_prefix"` |  |
| glueops_backups.tls_cert_backup.company_key | string | `"placeholder_tenant_key"` |  |
| glueops_backups.vault.aws_accessKey | string | `"placeholder_vault_aws_access_key"` | Part of `vault_s3_iam_credentials` output from terraform-module-cloud-multy-prerequisites: https://github.com/GlueOps/terraform-module-cloud-multy-prerequisites |
| glueops_backups.vault.aws_region | string | `"placeholder_aws_region"` | Should be the same `primary_region` you used in: https://github.com/GlueOps/terraform-module-cloud-multy-prerequisites |
| glueops_backups.vault.aws_secretKey | string | `"placeholder_vault_aws_secret_key"` | Part of `vault_s3_iam_credentials` output from terraform-module-cloud-multy-prerequisites: https://github.com/GlueOps/terraform-module-cloud-multy-prerequisites |
| glueops_backups.vault.company_key | string | `"placeholder_tenant_key"` |  |
| glueops_node_and_tolerations.nodeSelector."glueops.dev/role" | string | `"glueops-platform"` |  |
| glueops_node_and_tolerations.tolerations[0].effect | string | `"NoSchedule"` |  |
| glueops_node_and_tolerations.tolerations[0].key | string | `"glueops.dev/role"` |  |
| glueops_node_and_tolerations.tolerations[0].operator | string | `"Equal"` |  |
| glueops_node_and_tolerations.tolerations[0].value | string | `"glueops-platform"` |  |
| grafana.admin_password | string | `"placeholder_grafana_admin_password"` | Default admin password. CHANGE THIS!!!! |
| grafana.github_other_org_names | string | `"placeholder_tenant_github_org_name"` |  |
| host_network.cert_manager.webhook_secure_port | int | `45020` |  |
| host_network.enabled | string | `"placeholder_enable_host_network"` |  |
| host_network.external_secrets.webhook_port | int | `45010` |  |
| host_network.keda.prometheus.metricServer.port | int | `45056` |  |
| host_network.keda.prometheus.operator.port | int | `45055` |  |
| host_network.keda.prometheus.webhooks.port | int | `45054` |  |
| host_network.keda.service.portHttps | int | `45052` |  |
| host_network.keda.service.portHttpsTarget | int | `45053` |  |
| host_network.keda.webhooks.healthProbePort | int | `45051` |  |
| host_network.keda.webhooks.port | int | `45050` |  |
| host_network.kube_pometheus_stack.prometheusOperator.admissionWebhooks.deployment.tls.internal_port | int | `45041` |  |
| host_network.kube_pometheus_stack.prometheusOperator.tls.internal_port | int | `45040` |  |
| host_network.nginx_public.controller.host_port.ports.http | int | `45030` |  |
| host_network.nginx_public.controller.host_port.ports.https | int | `45031` |  |
| loki.aws_accessKey | string | `"placeholder_loki_aws_access_key"` | Part of `loki_s3_iam_credentials` output from terraform-module-cloud-multy-prerequisites: https://github.com/GlueOps/terraform-module-cloud-multy-prerequisites |
| loki.aws_region | string | `"placeholder_aws_region"` | Should be the same `primary_region` you used in: https://github.com/GlueOps/terraform-module-cloud-multy-prerequisites |
| loki.aws_secretKey | string | `"placeholder_loki_aws_secret_key"` | Part of `loki_s3_iam_credentials` output from terraform-module-cloud-multy-prerequisites: https://github.com/GlueOps/terraform-module-cloud-multy-prerequisites |
| loki.bucket | string | `"glueops-tenant-placeholder_tenant_key-placeholder_cluster_environment-loki-primary"` | Format: glueops-tenant-placeholder_tenant_key-placeholder_cluster_environment-loki-primary, Credentials found at `loki_credentials` of json output of terraform-module-cloud-multy-prerequisites |
| nginx.controller_replica_count | int | `2` | number of replicas for ingress controller |
| prometheus.volume_claim_storage_request | string | `"50"` | Volume of storage requested for each Prometheus PVC, in Gi |
| pull_request_bot.watch_for_apps_delay_seconds | string | `"10"` | number of seconds to wait before checking ArgoCD for new applications |
| tls_cert_restore.aws_accessKey | string | `"placeholder_tls_cert_restore_aws_access_key"` | Part of `loki_log_exporter` output from terraform-module-cloud-multy-prerequisites: https://github.com/GlueOps/terraform-module-cloud-multy-prerequisites |
| tls_cert_restore.aws_region | string | `"placeholder_aws_region"` | Should be the same `primary_region` you used in: https://github.com/GlueOps/terraform-module-cloud-multy-prerequisites |
| tls_cert_restore.aws_secretKey | string | `"placeholder_tls_cert_restore_aws_secret_key"` | Part of `loki_log_exporter` output from terraform-module-cloud-multy-prerequisites: https://github.com/GlueOps/terraform-module-cloud-multy-prerequisites |
| tls_cert_restore.backup_prefix | string | `"placeholder_tls_cert_backup_s3_key_prefix"` |  |
| tls_cert_restore.exclude_namespaces | string | `"placeholder_tls_cert_restore_exclude_namespaces"` |  |
| vault.data_storage | int | `10` | Volume of storage requested for each Vault Data PVC, in Gi |
| vault_init_controller.aws_accessKey | string | `"placeholder_vault_init_controller_aws_access_key"` | S3 Credentials to access the vault_access.json |
| vault_init_controller.aws_region | string | `"placeholder_aws_region"` | S3 region to access the vault_access.json |
| vault_init_controller.aws_secretKey | string | `"placeholder_vault_init_controller_aws_access_secret"` | S3 Credentials to access the vault_access.json |
| vault_init_controller.enable_restore | bool | `true` | Enable/Disable restore of an existing backup upon a fresh deployment of vault during cluster bootstrap |
| vault_init_controller.pause_reconcile | bool | `false` | Enable/Disable reconcile |
| vault_init_controller.reconcile_period | int | `30` | How often the controller should run |
| vault_init_controller.s3_bucket_name | string | `"glueops-tenant-placeholder_tenant_key-primary"` | S3 bucket that will store the vault unseal key(s) and root token |
| vault_init_controller.s3_key_path | string | `"placeholder_vault_init_controller_s3_key"` | S3 key/path to the unseal key(s) and root token |
