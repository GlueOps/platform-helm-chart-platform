# glueops-platform

![Version: 0.59.2](https://img.shields.io/badge/Version-0.59.2-informational?style=flat-square) ![AppVersion: v0.1.0](https://img.shields.io/badge/AppVersion-v0.1.0-informational?style=flat-square)

This chart deploys the GlueOps Platform

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| base_registry | string | `"ghcr.io/glueops/mirror"` |  |
| captain_domain | string | `"placeholder_cluster_environment.placeholder_tenant_key.placeholder_glueops_root_domain"` | The Route53 subdomain for the services on your cluster. It will be used as the suffix url for argocd, grafana, vault, and any other services that come out of the box in the glueops platform. Note: you need to create this before using this repo as this repo does not provision DNS Zones for you. This is the domain you created through: https://github.com/GlueOps/terraform-module-cloud-multy-prerequisites |
| captain_repo.private_b64enc_deploy_key | string | `"placeholder_captain_repo_b64enc_private_deploy_key"` | This is a read only deploy key that will be used to read the captain repo. Part of output from terraform-module-cloud-multy-prerequisites: https://github.com/GlueOps/terraform-module-cloud-multy-prerequisites |
| captain_repo.ssh_clone_url | string | `"placeholder_captain_repo_ssh_clone_url"` | This is the github url of the captain repo https://github.com/glueops/development-captains/tenant . Part of output from terraform-module-cloud-multy-prerequisites: https://github.com/GlueOps/terraform-module-cloud-multy-prerequisites |
| certManager.aws_accessKey | string | `"placeholder_certmanager_aws_access_key"` | Part of `certmanager_iam_credentials` output from terraform-module-cloud-multy-prerequisites: https://github.com/GlueOps/terraform-module-cloud-multy-prerequisites |
| certManager.aws_region | string | `"placeholder_aws_region"` | Should be the same `primary_region` you used in: https://github.com/GlueOps/terraform-module-cloud-multy-prerequisites |
| certManager.aws_secretKey | string | `"placeholder_certmanager_aws_secret_key"` | Part of `certmanager_iam_credentials` output from terraform-module-cloud-multy-prerequisites: https://github.com/GlueOps/terraform-module-cloud-multy-prerequisites |
| container_images.app_backup_and_exports.backup_tools.image.repository | string | `"glueops/backup-tools"` |  |
| container_images.app_backup_and_exports.backup_tools.image.tag | string | `"v0.19.0@sha256:b885eb2144e40231977b8b670117f5cd26572fdb78e8db2c04b53daab0b57e95"` |  |
| container_images.app_backup_and_exports.certs_backup_restore.image.repository | string | `"glueops/certs-backup-restore"` |  |
| container_images.app_backup_and_exports.certs_backup_restore.image.tag | string | `"v0.12.1@sha256:7ab9949f1b283a805262921c0d9b0044276df8414379b9e134d3c3ec484e44ec"` |  |
| container_images.app_backup_and_exports.vault_backup_validator.image.repository | string | `"glueops/vault-backup-validator"` |  |
| container_images.app_backup_and_exports.vault_backup_validator.image.tag | string | `"v0.3.6@sha256:b0b48ae02bdfa60a590312c0dbeb905261053ef46512c326b78eab9701d9b31b"` |  |
| container_images.app_cert_manager.cert_restore.image.repository | string | `"glueops/certs-backup-restore"` |  |
| container_images.app_cert_manager.cert_restore.image.tag | string | `"v0.12.5"` |  |
| container_images.app_cluster_info_page.cluster_information_help_page_html.image.repository | string | `"glueops/cluster-information-help-page-html"` |  |
| container_images.app_cluster_info_page.cluster_information_help_page_html.image.tag | string | `"v0.4.5@sha256:5f1843dfa2f76eea0a5e9a792867305d50b6f2d27e010d003a9ce79eb4188d16"` |  |
| container_images.app_dex.dex.image.repository | string | `"dexidp/dex"` |  |
| container_images.app_dex.dex.image.tag | string | `"v2.42.0@sha256:1b4a6eee8550240b0faedad04d984ca939513650e1d9bd423502c67355e3822f"` |  |
| container_images.app_external_secrets.external_secrets.image.repository | string | `"external-secrets/external-secrets"` |  |
| container_images.app_external_secrets.external_secrets.image.tag | string | `"v0.16.2@sha256:bf08e22f09fe2467d62ee54b54906c065d1fcb366ff47b1dbe18186b1788d649"` |  |
| container_images.app_fluent_operator.kubesphere.image.repository | string | `"kubesphere/fluent-operator"` |  |
| container_images.app_fluent_operator.kubesphere.image.tag | string | `"v2.7.0@sha256:b0668c0d878bde4ab04802a7e92d0dd3bef4c1fed1b5e63cf83d49bb3c5d3947"` |  |
| container_images.app_glueops_alerts.cluster_monitoring.image.repository | string | `"glueops/cluster-monitoring"` |  |
| container_images.app_glueops_alerts.cluster_monitoring.image.tag | string | `"v0.8.1@sha256:aa12c39244682d61a48fc374f97f318943c42c36347bf333105c5f4802721419"` |  |
| container_images.app_ingress_nginx.controller.image.repository | string | `"ingress-nginx/controller"` |  |
| container_images.app_ingress_nginx.controller.image.tag | string | `"v1.13.0@sha256:dc75a7baec7a3b827a5d7ab0acd10ab507904c7dad692365b3e3b596eca1afd2"` |  |
| container_images.app_kube_prometheus_stack.grafana.image.repository | string | `"grafana/grafana"` |  |
| container_images.app_kube_prometheus_stack.grafana.image.tag | string | `"10.4.19-security-01@sha256:5584505cb75be8cb14c19d7473a87e2675c68b34b546bc1923ef74300c337111"` |  |
| container_images.app_loki.loki.image.repository | string | `"grafana/loki"` |  |
| container_images.app_loki.loki.image.tag | string | `"2.9.10@sha256:35b02acc67654ddc38273e519b4f26f3967a907b9db5489af300c21f37ee1ae7"` |  |
| container_images.app_loki_alert_group_controller.loki_alert_group_controller.image.repository | string | `"glueops/metacontroller-operator-loki-rule-group"` |  |
| container_images.app_loki_alert_group_controller.loki_alert_group_controller.image.tag | string | `"v0.4.6@sha256:61aa2e48fd5c2277551daca68f287e77530a357d280a8199a5db5724b255401c"` |  |
| container_images.app_metacontroller.metacontroller.image.repository | string | `"metacontroller/metacontroller"` |  |
| container_images.app_metacontroller.metacontroller.image.tag | string | `"v4.12.3@sha256:12b3bd93a86487db2db5b631748d1b8a3f32819b2749b18aff169342546ecd4a"` |  |
| container_images.app_network_exporter.network_exporter.image.repository | string | `"syepes/network_exporter"` |  |
| container_images.app_network_exporter.network_exporter.image.tag | string | `"1.7.9@sha256:36cd647c80c30e3f5b78f9d2ca60f38e1d024fb3b9588a845cac2dc3f4fb75e1"` |  |
| container_images.app_oauth2_proxy.oauth2_proxy.image.repository | string | `"oauth2-proxy/oauth2-proxy"` |  |
| container_images.app_oauth2_proxy.oauth2_proxy.image.tag | string | `"v7.9.0@sha256:37c1570c0427e02fc7c947ef2c04e8995b8347b7abc9fcf1dbb4e376a4b221a7"` |  |
| container_images.app_promtail.promtail.image.repository | string | `"grafana/promtail"` |  |
| container_images.app_promtail.promtail.image.tag | string | `"2.9.10@sha256:63a2e57a5b1401109f77d36a49a637889d431280ed38f5f885eedcd3949e52cf"` |  |
| container_images.app_pull_request_bot.pull_request_bot.image.repository | string | `"glueops/pull-request-bot"` |  |
| container_images.app_pull_request_bot.pull_request_bot.image.tag | string | `"v0.22.3@sha256:b03549d0302622a9e672d7d502e5d5bba8c234a668ff5bc6fdb21c88abb34363"` |  |
| container_images.app_qr_code_generator.qr_code_generator.image.repository | string | `"glueops/qr-code-generator"` |  |
| container_images.app_qr_code_generator.qr_code_generator.image.tag | string | `"v0.7.1@sha256:884d67d4e17f3c4567dcb79eb3491099c448b58dc0c81ae848b50cd8cf314d22"` |  |
| container_images.app_vault.vault.image.repository | string | `"hashicorp/vault"` |  |
| container_images.app_vault.vault.image.tag | string | `"1.14.10@sha256:14be0a8eb323181a56d10facab3b424809d9921e85d2f2678126ce232766a8e1"` |  |
| container_images.app_vault_init_controller.vault_init_controller.image.repository | string | `"glueops/vault-init-controller"` |  |
| container_images.app_vault_init_controller.vault_init_controller.image.tag | string | `"v0.11.1@sha256:6015c7756613a364de039eb5a362df8eb49662df7d83cee2af5befba019b5d99"` |  |
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
| dex.oauth2.client_secret | string | `"placeholder_dex_oauth2_client_secret"` |  |
| dex.oauth2.cookie_secret | string | `"placeholder_dex_oauth2_cookie_secret"` |  |
| dex.vault.client_secret | string | `"placeholder_dex_vault_client_secret"` |  |
| enable_chisel_proxy_protocol | bool | `false` |  |
| externalDns.aws_accessKey | string | `"placeholder_externaldns_aws_access_key"` | Part of `externaldns_iam_credentials` output from terraform-module-cloud-multy-prerequisites: https://github.com/GlueOps/terraform-module-cloud-multy-prerequisites |
| externalDns.aws_region | string | `"placeholder_aws_region"` | Should be the same `primary_region` you used in: https://github.com/GlueOps/terraform-module-cloud-multy-prerequisites |
| externalDns.aws_secretKey | string | `"placeholder_externaldns_aws_secret_key"` | Part of `externaldns_iam_credentials` output from terraform-module-cloud-multy-prerequisites: https://github.com/GlueOps/terraform-module-cloud-multy-prerequisites |
| gitHub.github_app_b64enc_private_key | string | `"placeholder_github_tenant_app_b64enc_private_key"` |  |
| gitHub.github_app_id | string | `"placeholder_github_tenant_app_id"` | Create an Application in the tenant's github organization that has repo scope access and can comment against PRs. https://docs.github.com/en/apps/creating-github-apps/setting-up-a-github-app/creating-a-github-app.  Format the key using format using `cat <key-file> | base64 | tr -d '\n'` |
| gitHub.github_app_installation_id | string | `"placeholder_github_tenant_app_installation_id"` |  |
| gitHub.tenant_github_org | string | `"placeholder_tenant_github_org_name"` |  |
| gitHub.tenant_github_org_and_team | string | `"placeholder_tenant_github_org_name:developers"` | The format is: <github-org-name>:<github-team-name> (The team should include the developers) |
| glueops_alerts.opsgenie_apikey | string | `"placeholder_opsgenie_api_key"` | Found at `opsgenie_credentials` in the json output that is part of `opsgenie_prometheus_api_keys` output from terraform-module-cloud-multy-prerequisites: https://github.com/GlueOps/terraform-module-cloud-multy-prerequisites |
| glueops_backups.s3_bucket_name | string | `"placeholder_tenant_s3_multi_region_access_point"` |  |
| glueops_backups.tls_cert_backup.aws_accessKey | string | `"placeholder_tls_cert_backup_aws_access_key"` | Part of `loki_log_exporter` output from terraform-module-cloud-multy-prerequisites: https://github.com/GlueOps/terraform-module-cloud-multy-prerequisites |
| glueops_backups.tls_cert_backup.aws_region | string | `"placeholder_aws_region"` | Should be the same `primary_region` you used in: https://github.com/GlueOps/terraform-module-cloud-multy-prerequisites |
| glueops_backups.tls_cert_backup.aws_secretKey | string | `"placeholder_tls_cert_backup_aws_secret_key"` | Part of `loki_log_exporter` output from terraform-module-cloud-multy-prerequisites: https://github.com/GlueOps/terraform-module-cloud-multy-prerequisites |
| glueops_backups.tls_cert_backup.backup_prefix | string | `"placeholder_tls_cert_backup_s3_key_prefix"` |  |
| glueops_backups.tls_cert_backup.company_key | string | `"placeholder_tenant_key"` |  |
| glueops_backups.vault.aws_accessKey | string | `"placeholder_vault_aws_access_key"` | Part of `vault_s3_iam_credentials` output from terraform-module-cloud-multy-prerequisites: https://github.com/GlueOps/terraform-module-cloud-multy-prerequisites |
| glueops_backups.vault.aws_region | string | `"placeholder_aws_region"` | Should be the same `primary_region` you used in: https://github.com/GlueOps/terraform-module-cloud-multy-prerequisites |
| glueops_backups.vault.aws_secretKey | string | `"placeholder_vault_aws_secret_key"` | Part of `vault_s3_iam_credentials` output from terraform-module-cloud-multy-prerequisites: https://github.com/GlueOps/terraform-module-cloud-multy-prerequisites |
| glueops_backups.vault.backup_prefix | string | `"placeholder_vault_backup_s3_key_prefix"` |  |
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
| host_network.external_secrets.webhook_metrics_port | int | `45011` |  |
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
| vault_init_controller.s3_bucket_name | string | `"placeholder_tenant_s3_multi_region_access_point"` | S3 bucket that will store the vault unseal key(s) and root token |
| vault_init_controller.s3_key_path | string | `"placeholder_vault_init_controller_s3_key"` | S3 key/path to the unseal key(s) and root token |
