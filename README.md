# glueops-platform

![Version: 0.45.0-rc1](https://img.shields.io/badge/Version-0.45.0--rc1-informational?style=flat-square) ![AppVersion: v0.1.0](https://img.shields.io/badge/AppVersion-v0.1.0-informational?style=flat-square)

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
| container_images.app_backup_and_exports.backup_tools.image.tag | string | `"v0.12.0@sha256:aa1ff007fc2e30eb832bc13250253128de43a3ca427cd501f0c52d258addc300"` |  |
| container_images.app_backup_and_exports.certs_backup_restore.image.registry | string | `"ghcr.io"` |  |
| container_images.app_backup_and_exports.certs_backup_restore.image.repository | string | `"glueops/certs-backup-restore"` |  |
| container_images.app_backup_and_exports.certs_backup_restore.image.tag | string | `"v0.5.2@sha256:08be3a99d0327d229d1bd16896219faa315b1c165a794dc595c822354f40a4b4"` |  |
| container_images.app_backup_and_exports.vault_backup_validator.image.registry | string | `"ghcr.io"` |  |
| container_images.app_backup_and_exports.vault_backup_validator.image.repository | string | `"glueops/vault-backup-validator"` |  |
| container_images.app_backup_and_exports.vault_backup_validator.image.tag | string | `"v0.3.0@sha256:a30579c0d4dc07b3df0192d3dec4008fd159c908753f4d99c06f3e095371c7ff"` |  |
| container_images.app_cluster_info_page.cluster_information_help_page_html.image.registry | string | `"ghcr.io"` |  |
| container_images.app_cluster_info_page.cluster_information_help_page_html.image.repository | string | `"glueops/cluster-information-help-page-html"` |  |
| container_images.app_cluster_info_page.cluster_information_help_page_html.image.tag | string | `"v0.3.2@sha256:e6aa303a6aaad8919cd710305e48a08a40e996306e4bc7d60dea264201b91e98"` |  |
| container_images.app_dex.dex.image.registry | string | `"ghcr.io"` |  |
| container_images.app_dex.dex.image.repository | string | `"dexidp/dex"` |  |
| container_images.app_dex.dex.image.tag | string | `"v2.40.0@sha256:3e35d5d0f7dbd33fbadc36a71ff58cf4097ab98d73d22f6cb9a6471a32e028af"` |  |
| container_images.app_fluent_operator.image.registry | string | `"docker.io"` |  |
| container_images.app_fluent_operator.image.repository | string | `"kubesphere/fluent-operator"` |  |
| container_images.app_fluent_operator.image.tag | string | `"v2.7.0"` |  |
| container_images.app_glueops_alerts.cluster_monitoring.image.registry | string | `"ghcr.io"` |  |
| container_images.app_glueops_alerts.cluster_monitoring.image.repository | string | `"glueops/cluster-monitoring"` |  |
| container_images.app_glueops_alerts.cluster_monitoring.image.tag | string | `"v0.5.0@sha256:5a51c82b954c9b533439ec82776f8102b2d861059d8c4cc20b4b911d3fa34ef6"` |  |
| container_images.app_glueops_operator_redis.glueops_operator_shared_redis.image.registry | string | `"docker.io"` |  |
| container_images.app_glueops_operator_redis.glueops_operator_shared_redis.image.repository | string | `"redis"` |  |
| container_images.app_glueops_operator_redis.glueops_operator_shared_redis.image.tag | string | `"7.2.4-alpine3.19@sha256:c8bb255c3559b3e458766db810aa7b3c7af1235b204cfdb304e79ff388fe1a5a"` |  |
| container_images.app_glueops_operator_waf.glueops_operator_waf.image.registry | string | `"ghcr.io"` |  |
| container_images.app_glueops_operator_waf.glueops_operator_waf.image.repository | string | `"glueops/metacontroller-operator-waf"` |  |
| container_images.app_glueops_operator_waf.glueops_operator_waf.image.tag | string | `"v0.8.1@sha256:7eb27cf2af062e8df68f88c093167ef11bdaa99173ed05ed05743439127d5ac2"` |  |
| container_images.app_glueops_operator_waf_web_acl.glueops_operator_waf_web_acl.image.registry | string | `"ghcr.io"` |  |
| container_images.app_glueops_operator_waf_web_acl.glueops_operator_waf_web_acl.image.repository | string | `"glueops/metacontroller-operator-waf-web-acl"` |  |
| container_images.app_glueops_operator_waf_web_acl.glueops_operator_waf_web_acl.image.tag | string | `"v0.5.1@sha256:696ff30a9b333b8f4e5a0552b889af642dbf873eba3a4d4c32619aac9670d8ea"` |  |
| container_images.app_kube_prometheus_stack.grafana.image.registry | string | `"docker.io"` |  |
| container_images.app_kube_prometheus_stack.grafana.image.repository | string | `"grafana/grafana"` |  |
| container_images.app_kube_prometheus_stack.grafana.image.tag | string | `"10.4.4@sha256:70c3ee3970a24fff58d1aed7d381576057e1eb76f0df2f6552691f34244835f8"` |  |
| container_images.app_loki.loki.image.registry | string | `"docker.io"` |  |
| container_images.app_loki.loki.image.repository | string | `"grafana/loki"` |  |
| container_images.app_loki.loki.image.tag | string | `"2.9.8@sha256:8b5bd7748d0e4da66cd741ac276e485517514af0bea32167e27c0e1a95bcf8aa"` |  |
| container_images.app_loki_alert_group_controller.loki_alert_group_controller.image.registry | string | `"ghcr.io"` |  |
| container_images.app_loki_alert_group_controller.loki_alert_group_controller.image.repository | string | `"glueops/metacontroller-operator-loki-rule-group"` |  |
| container_images.app_loki_alert_group_controller.loki_alert_group_controller.image.tag | string | `"v0.4.0@sha256:c9f4957e290021ad87ca9a20c787ab38dbea2472b2e12c446e4a39c8cd359d21"` |  |
| container_images.app_metacontroller.metacontroller.image.registry | string | `"ghcr.io"` |  |
| container_images.app_metacontroller.metacontroller.image.repository | string | `"metacontroller/metacontroller"` |  |
| container_images.app_metacontroller.metacontroller.image.tag | string | `"v4.11.14@sha256:579b627b0a158bf5d746ebb692632e68f3cee2be82610244c3cf8b0da75b6452"` |  |
| container_images.app_network_exporter.network_exporter.image.registry | string | `"docker.io"` |  |
| container_images.app_network_exporter.network_exporter.image.repository | string | `"syepes/network_exporter"` |  |
| container_images.app_network_exporter.network_exporter.image.tag | string | `"1.7.6@sha256:376c3c80026e79d76eec3a3a1f22621ad6846525c458bb7f1423f3da6398482f"` |  |
| container_images.app_promtail.promtail.image.registry | string | `"docker.io"` |  |
| container_images.app_promtail.promtail.image.repository | string | `"grafana/promtail"` |  |
| container_images.app_promtail.promtail.image.tag | string | `"2.9.8@sha256:45d54f0ebd7a19acbcd4693a3227d84d27d98abe1dc7ea3068d31d5d02dbe696"` |  |
| container_images.app_pull_request_bot.pull_request_bot.image.registry | string | `"ghcr.io"` |  |
| container_images.app_pull_request_bot.pull_request_bot.image.repository | string | `"glueops/pull-request-bot"` |  |
| container_images.app_pull_request_bot.pull_request_bot.image.tag | string | `"v0.17.0@sha256:20eeaacf9a988925a125e64a5439607afa6092bed2fa1403d9d39cf9f26a2aaf"` |  |
| container_images.app_qr_code_generator.qr_code_generator.image.registry | string | `"ghcr.io"` |  |
| container_images.app_qr_code_generator.qr_code_generator.image.repository | string | `"glueops/qr-code-generator"` |  |
| container_images.app_qr_code_generator.qr_code_generator.image.tag | string | `"v0.4.2@sha256:60a56809c0554895e0412a77e0acb5702f0814e4db6a077c1a41d689df70b66c"` |  |
| container_images.app_vault.vault.image.registry | string | `"docker.io"` |  |
| container_images.app_vault.vault.image.repository | string | `"hashicorp/vault"` |  |
| container_images.app_vault.vault.image.tag | string | `"1.14.10@sha256:14be0a8eb323181a56d10facab3b424809d9921e85d2f2678126ce232766a8e1"` |  |
| container_images.app_vault_init_controller.vault_init_controller.image.registry | string | `"ghcr.io"` |  |
| container_images.app_vault_init_controller.vault_init_controller.image.repository | string | `"glueops/vault-init-controller"` |  |
| container_images.app_vault_init_controller.vault_init_controller.image.tag | string | `"v0.6.1@sha256:08bc8b4e981700fe2ce238efe088a2ed25650f36381010c08da9427bf0cd2adb"` |  |
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
| glueops_backups.loki_exporter_to_s3.aws_accessKey | string | `"placeholder_loki_exporter_aws_access_key"` | Part of `loki_log_exporter` output from terraform-module-cloud-multy-prerequisites: https://github.com/GlueOps/terraform-module-cloud-multy-prerequisites |
| glueops_backups.loki_exporter_to_s3.aws_region | string | `"placeholder_aws_region"` | Should be the same `primary_region` you used in: https://github.com/GlueOps/terraform-module-cloud-multy-prerequisites |
| glueops_backups.loki_exporter_to_s3.aws_secretKey | string | `"placeholder_loki_exporter_aws_secret_key"` | Part of `loki_log_exporter` output from terraform-module-cloud-multy-prerequisites: https://github.com/GlueOps/terraform-module-cloud-multy-prerequisites |
| glueops_backups.loki_exporter_to_s3.company_key | string | `"placeholder_tenant_key"` |  |
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
| glueops_operators.waf.aws_accessKey | string | `"placeholder_glueops_operators_waf_aws_access_key"` |  |
| glueops_operators.waf.aws_secretKey | string | `"placeholder_glueops_operators_waf_aws_secret_key"` |  |
| glueops_operators.web_acl.aws_accessKey | string | `"placeholder_glueops_operators_web_acl_aws_access_key"` |  |
| glueops_operators.web_acl.aws_secretKey | string | `"placeholder_glueops_operators_web_acl_aws_secret_key"` |  |
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
