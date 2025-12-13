# glueops-platform

![Version: 0.65.0](https://img.shields.io/badge/Version-0.65.0-informational?style=flat-square) ![AppVersion: v0.1.0](https://img.shields.io/badge/AppVersion-v0.1.0-informational?style=flat-square)

This chart deploys the GlueOps Platform

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| base_registries.docker_io | string | `"replicas.mirror.gpkg.io/proxy-docker-io"` |  |
| base_registries.gcr_io | string | `"replicas.mirror.gpkg.io/proxy-gcr-io"` |  |
| base_registries.ghcr_io | string | `"replicas.mirror.gpkg.io/proxy-ghcr-io"` |  |
| base_registries.mcr_microsoft_com | string | `"replicas.mirror.gpkg.io/proxy-mcr-microsoft-com"` |  |
| base_registries.public_ecr_aws | string | `"replicas.mirror.gpkg.io/proxy-public-ecr-aws"` |  |
| base_registries.quay_io | string | `"replicas.mirror.gpkg.io/proxy-quay-io"` |  |
| base_registries.registry_k8s_io | string | `"replicas.mirror.gpkg.io/proxy-registry-k8s-io"` |  |
| captain_domain | string | `"placeholder_cluster_environment.placeholder_tenant_key.placeholder_glueops_root_domain"` | The Route53 subdomain for the services on your cluster. It will be used as the suffix url for argocd, grafana, vault, and any other services that come out of the box in the glueops platform. Note: you need to create this before using this repo as this repo does not provision DNS Zones for you. This is the domain you created through: https://github.com/GlueOps/terraform-module-cloud-multy-prerequisites |
| captain_repo.private_b64enc_deploy_key | string | `"placeholder_captain_repo_b64enc_private_deploy_key"` | This is a read only deploy key that will be used to read the captain repo. Part of output from terraform-module-cloud-multy-prerequisites: https://github.com/GlueOps/terraform-module-cloud-multy-prerequisites |
| captain_repo.ssh_clone_url | string | `"placeholder_captain_repo_ssh_clone_url"` | This is the github url of the captain repo https://github.com/glueops/development-captains/tenant . Part of output from terraform-module-cloud-multy-prerequisites: https://github.com/GlueOps/terraform-module-cloud-multy-prerequisites |
| certManager.aws_accessKey | string | `"placeholder_certmanager_aws_access_key"` | Part of `certmanager_iam_credentials` output from terraform-module-cloud-multy-prerequisites: https://github.com/GlueOps/terraform-module-cloud-multy-prerequisites |
| certManager.aws_region | string | `"placeholder_aws_region"` | Should be the same `primary_region` you used in: https://github.com/GlueOps/terraform-module-cloud-multy-prerequisites |
| certManager.aws_secretKey | string | `"placeholder_certmanager_aws_secret_key"` | Part of `certmanager_iam_credentials` output from terraform-module-cloud-multy-prerequisites: https://github.com/GlueOps/terraform-module-cloud-multy-prerequisites |
| container_images.app_backup_and_exports.backup_tools.image.registry | string | `"replicas.mirror.gpkg.io/proxy-ghcr-io"` |  |
| container_images.app_backup_and_exports.backup_tools.image.repository | string | `"glueops/backup-tools"` |  |
| container_images.app_backup_and_exports.backup_tools.image.tag | string | `"v2.7.0@sha256:64e194438f3d056b4a658978be30cd06dce2d37e8df65db611b65aad0e7c3231"` |  |
| container_images.app_backup_and_exports.certs_backup_restore.image.registry | string | `"replicas.mirror.gpkg.io/proxy-ghcr-io"` |  |
| container_images.app_backup_and_exports.certs_backup_restore.image.repository | string | `"glueops/certs-backup-restore"` |  |
| container_images.app_backup_and_exports.certs_backup_restore.image.tag | string | `"v0.12.8@sha256:1edd17bfd8737b7231c17fc93167be1ad16fa025f9b237e01fbf39a4df76117d"` |  |
| container_images.app_backup_and_exports.vault_backup_validator.image.registry | string | `"replicas.mirror.gpkg.io/proxy-ghcr-io"` |  |
| container_images.app_backup_and_exports.vault_backup_validator.image.repository | string | `"glueops/vault-backup-validator"` |  |
| container_images.app_backup_and_exports.vault_backup_validator.image.tag | string | `"v2.5.0@sha256:560c7a3167d14b1fab74857771eb3a2c159c93ce206e3f5b7ce9395b17b4650b"` |  |
| container_images.app_cert_manager.cert_manager.image.registry | string | `"replicas.mirror.gpkg.io/proxy-quay-io"` |  |
| container_images.app_cert_manager.cert_manager.image.repository | string | `"jetstack/cert-manager-controller"` |  |
| container_images.app_cert_manager.cert_manager.image.tag | string | `"v1.18.2@sha256:81316365dc0b713eddddfbf9b8907b2939676e6c0e12beec0f9625f202a36d16"` |  |
| container_images.app_cert_manager.cert_restore.image.registry | string | `"replicas.mirror.gpkg.io/proxy-ghcr-io"` |  |
| container_images.app_cert_manager.cert_restore.image.repository | string | `"glueops/certs-backup-restore"` |  |
| container_images.app_cert_manager.cert_restore.image.tag | string | `"v0.12.8@sha256:1edd17bfd8737b7231c17fc93167be1ad16fa025f9b237e01fbf39a4df76117d"` |  |
| container_images.app_cluster_info_page.cluster_information_help_page_html.image.registry | string | `"replicas.mirror.gpkg.io/proxy-ghcr-io"` |  |
| container_images.app_cluster_info_page.cluster_information_help_page_html.image.repository | string | `"glueops/cluster-information-help-page-html"` |  |
| container_images.app_cluster_info_page.cluster_information_help_page_html.image.tag | string | `"v0.5.0@sha256:5396f0638205a218f40d6c71edeff538b2e44dae63d3ffc34cb0b75f37b3964b"` |  |
| container_images.app_curlimages.curl.image.registry | string | `"replicas.mirror.gpkg.io/proxy-docker-io"` |  |
| container_images.app_curlimages.curl.image.repository | string | `"curlimages/curl"` |  |
| container_images.app_curlimages.curl.image.tag | string | `"8.16.0@sha256:463eaf6072688fe96ac64fa623fe73e1dbe25d8ad6c34404a669ad3ce1f104b6"` |  |
| container_images.app_descheduler.descheduler.image.registry | string | `"replicas.mirror.gpkg.io/proxy-registry-k8s-io"` |  |
| container_images.app_descheduler.descheduler.image.repository | string | `"descheduler/descheduler"` |  |
| container_images.app_descheduler.descheduler.image.tag | string | `"v0.33.0"` |  |
| container_images.app_dex.dex.image.registry | string | `"replicas.mirror.gpkg.io/proxy-ghcr-io"` |  |
| container_images.app_dex.dex.image.repository | string | `"dexidp/dex"` |  |
| container_images.app_dex.dex.image.tag | string | `"v2.44.0@sha256:5d0656fce7d453c0e3b2706abf40c0d0ce5b371fb0b73b3cf714d05f35fa5f86"` |  |
| container_images.app_external_dns.external_dns.image.registry | string | `"replicas.mirror.gpkg.io/proxy-registry-k8s-io"` |  |
| container_images.app_external_dns.external_dns.image.repository | string | `"external-dns/external-dns"` |  |
| container_images.app_external_dns.external_dns.image.tag | string | `"v0.17.0@sha256:85eba2727b410c8f8093d641a4b1a29671878db94d525a70a4108d10ba8eef5f"` |  |
| container_images.app_external_secrets.external_secrets.image.registry | string | `"replicas.mirror.gpkg.io/proxy-ghcr-io"` |  |
| container_images.app_external_secrets.external_secrets.image.repository | string | `"external-secrets/external-secrets"` |  |
| container_images.app_external_secrets.external_secrets.image.tag | string | `"v0.16.2@sha256:bf08e22f09fe2467d62ee54b54906c065d1fcb366ff47b1dbe18186b1788d649"` |  |
| container_images.app_fluent_operator.kubesphere.image.registry | string | `"replicas.mirror.gpkg.io/proxy-docker-io"` |  |
| container_images.app_fluent_operator.kubesphere.image.repository | string | `"kubesphere/fluent-operator"` |  |
| container_images.app_fluent_operator.kubesphere.image.tag | string | `"v2.7.0@sha256:b0668c0d878bde4ab04802a7e92d0dd3bef4c1fed1b5e63cf83d49bb3c5d3947"` |  |
| container_images.app_glueops_alerts.cluster_monitoring.image.registry | string | `"replicas.mirror.gpkg.io/proxy-ghcr-io"` |  |
| container_images.app_glueops_alerts.cluster_monitoring.image.repository | string | `"glueops/cluster-monitoring"` |  |
| container_images.app_glueops_alerts.cluster_monitoring.image.tag | string | `"v0.8.2@sha256:06bad372dfd21d2bf807d26fb6d354f885d7e4fe63a2108f7446f20be2b5413d"` |  |
| container_images.app_go_healthz.go_healthz.image.registry | string | `"replicas.mirror.gpkg.io/proxy-ghcr-io"` |  |
| container_images.app_go_healthz.go_healthz.image.repository | string | `"glueops/go-healthz"` |  |
| container_images.app_go_healthz.go_healthz.image.tag | string | `"v0.0.10@sha256:64dd3450a234497d36acc028c58615a21b4bd6850c9c0343bb0319c3db0ba04c"` |  |
| container_images.app_ingress_nginx.controller.image.registry | string | `"replicas.mirror.gpkg.io/proxy-registry-k8s-io"` |  |
| container_images.app_ingress_nginx.controller.image.repository | string | `"ingress-nginx/controller"` |  |
| container_images.app_ingress_nginx.controller.image.tag | string | `"v1.13.3@sha256:1b044f6dcac3afbb59e05d98463f1dec6f3d3fb99940bc12ca5d80270358e3bd"` |  |
| container_images.app_kube_prometheus_stack.grafana.image.registry | string | `"replicas.mirror.gpkg.io/proxy-docker-io"` |  |
| container_images.app_kube_prometheus_stack.grafana.image.repository | string | `"grafana/grafana"` |  |
| container_images.app_kube_prometheus_stack.grafana.image.tag | string | `"10.4.19-security-01@sha256:5584505cb75be8cb14c19d7473a87e2675c68b34b546bc1923ef74300c337111"` |  |
| container_images.app_loki.loki.image.registry | string | `"replicas.mirror.gpkg.io/proxy-docker-io"` |  |
| container_images.app_loki.loki.image.repository | string | `"grafana/loki"` |  |
| container_images.app_loki.loki.image.tag | string | `"2.9.10@sha256:35b02acc67654ddc38273e519b4f26f3967a907b9db5489af300c21f37ee1ae7"` |  |
| container_images.app_loki_alert_group_controller.loki_alert_group_controller.image.registry | string | `"replicas.mirror.gpkg.io/proxy-ghcr-io"` |  |
| container_images.app_loki_alert_group_controller.loki_alert_group_controller.image.repository | string | `"glueops/metacontroller-operator-loki-rule-group"` |  |
| container_images.app_loki_alert_group_controller.loki_alert_group_controller.image.tag | string | `"v0.4.6@sha256:61aa2e48fd5c2277551daca68f287e77530a357d280a8199a5db5724b255401c"` |  |
| container_images.app_metacontroller.metacontroller.image.registry | string | `"replicas.mirror.gpkg.io/proxy-ghcr-io"` |  |
| container_images.app_metacontroller.metacontroller.image.repository | string | `"metacontroller/metacontroller"` |  |
| container_images.app_metacontroller.metacontroller.image.tag | string | `"v4.12.5@sha256:8d8f21f3f4e36897b6405f5507fefce209ae805425e556361d93f3ae0ed16ce6"` |  |
| container_images.app_network_exporter.network_exporter.image.registry | string | `"replicas.mirror.gpkg.io/proxy-docker-io"` |  |
| container_images.app_network_exporter.network_exporter.image.repository | string | `"syepes/network_exporter"` |  |
| container_images.app_network_exporter.network_exporter.image.tag | string | `"1.7.10@sha256:66b0468ca13c59556b2658eaa31520e615c83cdafb4b194a0e792ebe7630ef69"` |  |
| container_images.app_oauth2_proxy.oauth2_proxy.image.registry | string | `"replicas.mirror.gpkg.io/proxy-quay-io"` |  |
| container_images.app_oauth2_proxy.oauth2_proxy.image.repository | string | `"oauth2-proxy/oauth2-proxy"` |  |
| container_images.app_oauth2_proxy.oauth2_proxy.image.tag | string | `"v7.13.0@sha256:56e3daedf765c7a1eea6e366fbe684be7d3084830ade14b6174570d3c7960954"` |  |
| container_images.app_promtail.promtail.image.registry | string | `"replicas.mirror.gpkg.io/proxy-docker-io"` |  |
| container_images.app_promtail.promtail.image.repository | string | `"grafana/promtail"` |  |
| container_images.app_promtail.promtail.image.tag | string | `"2.9.10@sha256:63a2e57a5b1401109f77d36a49a637889d431280ed38f5f885eedcd3949e52cf"` |  |
| container_images.app_pull_request_bot.pull_request_bot.image.registry | string | `"replicas.mirror.gpkg.io/proxy-ghcr-io"` |  |
| container_images.app_pull_request_bot.pull_request_bot.image.repository | string | `"glueops/pull-request-bot"` |  |
| container_images.app_pull_request_bot.pull_request_bot.image.tag | string | `"v1.1.0@sha256:f8b5eb18e1194f08ad0decddcf2c7ef73aaf22953347aca77d2e528a68549c67"` |  |
| container_images.app_qr_code_generator.qr_code_generator.image.registry | string | `"replicas.mirror.gpkg.io/proxy-ghcr-io"` |  |
| container_images.app_qr_code_generator.qr_code_generator.image.repository | string | `"glueops/qr-code-generator"` |  |
| container_images.app_qr_code_generator.qr_code_generator.image.tag | string | `"v1.0.1@sha256:3ce0da14140856f0a8d8c39f8155903d14ca145f2d35ca09be8c2aba465b7a3e"` |  |
| container_images.app_vault.vault.image.registry | string | `"replicas.mirror.gpkg.io/proxy-quay-io"` |  |
| container_images.app_vault.vault.image.repository | string | `"openbao/openbao"` |  |
| container_images.app_vault.vault.image.tag | string | `"2.4.4@sha256:595c83b42614a4d2b044608e4593c05b019c5db25bc9c185d8fff3ac96c03ddd"` |  |
| container_images.app_vault_init_controller.vault_init_controller.image.registry | string | `"replicas.mirror.gpkg.io/proxy-ghcr-io"` |  |
| container_images.app_vault_init_controller.vault_init_controller.image.repository | string | `"glueops/vault-init-controller"` |  |
| container_images.app_vault_init_controller.vault_init_controller.image.tag | string | `"v2.3.0@sha256:6ded1c0defe0040fbccd6a91b6f37355c1b0a52ac16fe46ce0c9fa34f2dfe2a6"` |  |
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
| kube_etcd.enabled | string | `"placeholder_enable_kubeadm_cluster"` |  |
| kube_etcd.serviceMonitor.caFile | string | `"/etc/prometheus/secrets/etcd-client/ca.crt"` |  |
| kube_etcd.serviceMonitor.certFile | string | `"/etc/prometheus/secrets/etcd-client/apiserver-etcd-client.crt"` |  |
| kube_etcd.serviceMonitor.keyFile | string | `"/etc/prometheus/secrets/etcd-client/apiserver-etcd-client.key"` |  |
| loki.chunkConfig | object | `{"allocatedMemory":2024,"batchSize":2,"maxItemMemory":2,"parallelism":2,"replicas":2,"writebackBuffer":1000,"writebackParallelism":1,"writebackSizeLimit":"500MB"}` | Check https://grafana.com/docs/loki/latest/configure/#s3_storage_config for more info on how to provide a backoff_config backoff_config: {} disable_dualstack: false https://docs.memcached.org/advisories/grafanaloki/ https://grafana.com/blog/2023/08/23/how-we-scaled-grafana-cloud-logs-memcached-cluster-to-50tb-and-improved-reliability/     |
| loki.storage | string | `nil` |  |
| nginx.controller_replica_count | int | `2` | number of replicas for ingress controller |
| node_ports.enabled | string | `"placeholder_enable_kubeadm_cluster"` |  |
| node_ports.nginx.ports.http | int | `30020` |  |
| node_ports.nginx.ports.https | int | `30021` |  |
| node_ports.oauth2_proxy.ports.http | int | `30010` |  |
| node_ports.oauth2_proxy.ports.https | int | `30011` |  |
| pull_request_bot.watch_for_apps_delay_seconds | string | `"10"` | number of seconds to wait before checking ArgoCD for new applications |
| tempo.compaction_block_retention | string | `"168h"` |  |
| tempo.remote_url[0] | string | `"http://localhost:9090/api/v1/write"` |  |
| tempo.storage.placeholder_tempo_storage | object | `{}` |  |
| thanos.storage | string | `nil` | Format: glueops-tenant-placeholder_tenant_key-placeholder_cluster_environment-loki-primary, Credentials found at `loki_credentials` of json output of terraform-module-cloud-multy-prerequisites |
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
