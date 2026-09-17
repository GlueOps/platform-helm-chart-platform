# glueops-platform

![Version: 0.79.2](https://img.shields.io/badge/Version-0.79.2-informational?style=flat-square) ![AppVersion: v0.1.0](https://img.shields.io/badge/AppVersion-v0.1.0-informational?style=flat-square)

This chart deploys the GlueOps Platform

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| base_registries.docker_io | string | `"dockerhub.repo.gpkg.io"` |  |
| base_registries.ghcr_io | string | `"ghcr.repo.gpkg.io"` |  |
| base_registries.public_ecr_aws | string | `"ecr.repo.gpkg.io"` |  |
| base_registries.quay_io | string | `"quay.repo.gpkg.io"` |  |
| base_registries.registry_k8s_io | string | `"k8s.repo.gpkg.io"` |  |
| captain_domain | string | `"placeholder_cluster_environment.placeholder_tenant_key.placeholder_glueops_root_domain"` | The Route53 subdomain for the services on your cluster. It will be used as the suffix url for argocd, grafana, vault, and any other services that come out of the box in the glueops platform. Note: you need to create this before using this repo as this repo does not provision DNS Zones for you. This is the domain you created through: https://github.com/GlueOps/terraform-module-cloud-multy-prerequisites |
| captain_repo.private_b64enc_deploy_key | string | `"placeholder_captain_repo_b64enc_private_deploy_key"` | This is a read only deploy key that will be used to read the captain repo. Part of output from terraform-module-cloud-multy-prerequisites: https://github.com/GlueOps/terraform-module-cloud-multy-prerequisites |
| captain_repo.ssh_clone_url | string | `"placeholder_captain_repo_ssh_clone_url"` | This is the github url of the captain repo https://github.com/glueops/development-captains/tenant . Part of output from terraform-module-cloud-multy-prerequisites: https://github.com/GlueOps/terraform-module-cloud-multy-prerequisites |
| certManager.aws_accessKey | string | `"placeholder_certmanager_aws_access_key"` | Part of `certmanager_iam_credentials` output from terraform-module-cloud-multy-prerequisites: https://github.com/GlueOps/terraform-module-cloud-multy-prerequisites |
| certManager.aws_region | string | `"placeholder_aws_region"` | Should be the same `primary_region` you used in: https://github.com/GlueOps/terraform-module-cloud-multy-prerequisites |
| certManager.aws_secretKey | string | `"placeholder_certmanager_aws_secret_key"` | Part of `certmanager_iam_credentials` output from terraform-module-cloud-multy-prerequisites: https://github.com/GlueOps/terraform-module-cloud-multy-prerequisites |
| container_images.app_backup_and_exports.backup_tools.image.registry | string | `"ghcr.repo.gpkg.io"` |  |
| container_images.app_backup_and_exports.backup_tools.image.repository | string | `"glueops/backup-tools"` |  |
| container_images.app_backup_and_exports.backup_tools.image.tag | string | `"v2.18.0@sha256:c0a3f220c8425bed27acdc7e4bf58f9f8ae42effaf4ef66e25e8c77ae3f2f95d"` |  |
| container_images.app_backup_and_exports.certs_backup_restore.image.registry | string | `"ghcr.repo.gpkg.io"` |  |
| container_images.app_backup_and_exports.certs_backup_restore.image.repository | string | `"glueops/certs-backup-restore"` |  |
| container_images.app_backup_and_exports.certs_backup_restore.image.tag | string | `"v2.4.0@sha256:d2c6a534ecc06017eabc80cc2554ca41cae5a64509d7dddc9dfe46459be11e3e"` |  |
| container_images.app_backup_and_exports.vault_backup_validator.image.registry | string | `"ghcr.repo.gpkg.io"` |  |
| container_images.app_backup_and_exports.vault_backup_validator.image.repository | string | `"glueops/vault-backup-validator"` |  |
| container_images.app_backup_and_exports.vault_backup_validator.image.tag | string | `"v2.18.0@sha256:b6cc233317499aafb891773faa88ec43a701ebe253165403fe79aa69d39352d8"` |  |
| container_images.app_cert_manager.acmesolver.image.registry | string | `"quay.repo.gpkg.io"` |  |
| container_images.app_cert_manager.acmesolver.image.repository | string | `"jetstack/cert-manager-acmesolver"` |  |
| container_images.app_cert_manager.acmesolver.image.tag | string | `"v1.21.2@sha256:699b40d622211ab7accad8a21b04c5fbaa1841ef7a12621e8de492dbe27b2503"` |  |
| container_images.app_cert_manager.cainjector.image.registry | string | `"quay.repo.gpkg.io"` |  |
| container_images.app_cert_manager.cainjector.image.repository | string | `"jetstack/cert-manager-cainjector"` |  |
| container_images.app_cert_manager.cainjector.image.tag | string | `"v1.21.2@sha256:c85268c64f2e0e76684bf5fe8906caff34b82523561c6affe0fae3546bd87562"` |  |
| container_images.app_cert_manager.cert_manager.image.registry | string | `"quay.repo.gpkg.io"` |  |
| container_images.app_cert_manager.cert_manager.image.repository | string | `"jetstack/cert-manager-controller"` |  |
| container_images.app_cert_manager.cert_manager.image.tag | string | `"v1.21.2@sha256:70f532fd9cfde0b09d55687200942399d89838bc2d5d5b45152eb799a15912b8"` |  |
| container_images.app_cert_manager.cert_restore.image.registry | string | `"ghcr.repo.gpkg.io"` |  |
| container_images.app_cert_manager.cert_restore.image.repository | string | `"glueops/certs-backup-restore"` |  |
| container_images.app_cert_manager.cert_restore.image.tag | string | `"v2.4.0@sha256:d2c6a534ecc06017eabc80cc2554ca41cae5a64509d7dddc9dfe46459be11e3e"` |  |
| container_images.app_cert_manager.startupapicheck.image.registry | string | `"quay.repo.gpkg.io"` |  |
| container_images.app_cert_manager.startupapicheck.image.repository | string | `"jetstack/cert-manager-startupapicheck"` |  |
| container_images.app_cert_manager.startupapicheck.image.tag | string | `"v1.21.2@sha256:46e75b6866359ffb5d82624f41e3ed1c70b2994982702ced547ce5edb418a8f5"` |  |
| container_images.app_cert_manager.webhook.image.registry | string | `"quay.repo.gpkg.io"` |  |
| container_images.app_cert_manager.webhook.image.repository | string | `"jetstack/cert-manager-webhook"` |  |
| container_images.app_cert_manager.webhook.image.tag | string | `"v1.21.2@sha256:a60e2dac46dbb8a7f3df95c54ce941012f54c2fe022f0ee55aaa1ab40ed957ae"` |  |
| container_images.app_cluster_info_page.cluster_information_help_page_html.image.registry | string | `"ghcr.repo.gpkg.io"` |  |
| container_images.app_cluster_info_page.cluster_information_help_page_html.image.repository | string | `"glueops/cluster-information-help-page-html"` |  |
| container_images.app_cluster_info_page.cluster_information_help_page_html.image.tag | string | `"v4.30.2@sha256:ccd43ecafd24ced075fe66182b749c8247fc2c1dcb9e0a395994d4642cbc70c4"` |  |
| container_images.app_curlimages.curl.image.registry | string | `"dockerhub.repo.gpkg.io"` |  |
| container_images.app_curlimages.curl.image.repository | string | `"curlimages/curl"` |  |
| container_images.app_curlimages.curl.image.tag | string | `"8.22.0@sha256:58adaa4e8dca9c988bae2aba4ab3434a0bb2da16bbe3f92dec39ec7785166777"` |  |
| container_images.app_descheduler.descheduler.image.registry | string | `"k8s.repo.gpkg.io"` |  |
| container_images.app_descheduler.descheduler.image.repository | string | `"descheduler/descheduler"` |  |
| container_images.app_descheduler.descheduler.image.tag | string | `"v0.36.0"` |  |
| container_images.app_dex.dex.image.registry | string | `"ghcr.repo.gpkg.io"` |  |
| container_images.app_dex.dex.image.repository | string | `"dexidp/dex"` |  |
| container_images.app_dex.dex.image.tag | string | `"v2.45.1@sha256:8499afd690c437f52301efd2b05b2455da5bd2dfc20332cd697dc9937f808462"` |  |
| container_images.app_external_dns.external_dns.image.registry | string | `"k8s.repo.gpkg.io"` |  |
| container_images.app_external_dns.external_dns.image.repository | string | `"external-dns/external-dns"` |  |
| container_images.app_external_dns.external_dns.image.tag | string | `"v0.22.0@sha256:5fdcaf7deb5c158f93a1fc6fe169cdff4cfb9ae0172bee1a90ab0ef74fb9c9cf"` |  |
| container_images.app_external_secrets.external_secrets.image.registry | string | `"ghcr.repo.gpkg.io"` |  |
| container_images.app_external_secrets.external_secrets.image.repository | string | `"external-secrets/external-secrets"` |  |
| container_images.app_external_secrets.external_secrets.image.tag | string | `"v2.10.0@sha256:814117b0fd6d121b03e8ba3b6db1cecbe7449a354fc0fc9c4faf73a37aa221b1"` |  |
| container_images.app_fluent_operator.kubesphere.image.registry | string | `"dockerhub.repo.gpkg.io"` |  |
| container_images.app_fluent_operator.kubesphere.image.repository | string | `"kubesphere/fluent-operator"` |  |
| container_images.app_fluent_operator.kubesphere.image.tag | string | `"v2.7.0@sha256:b0668c0d878bde4ab04802a7e92d0dd3bef4c1fed1b5e63cf83d49bb3c5d3947"` |  |
| container_images.app_gluekube_ccm.gluekube_ccm.image.registry | string | `"ghcr.repo.gpkg.io"` |  |
| container_images.app_gluekube_ccm.gluekube_ccm.image.repository | string | `"glueops/gluekube-ccm"` |  |
| container_images.app_gluekube_ccm.gluekube_ccm.image.tag | string | `"v0.43.0@sha256:7d6a5d89665d31b26122376b33e89dde79626f244c0688e2a7cf858e917a4feb"` |  |
| container_images.app_go_healthz.go_healthz.image.registry | string | `"ghcr.repo.gpkg.io"` |  |
| container_images.app_go_healthz.go_healthz.image.repository | string | `"glueops/go-healthz"` |  |
| container_images.app_go_healthz.go_healthz.image.tag | string | `"v0.2.1@sha256:929c2ca16d9868f35f0e1ab309caf9766d948df9fac43e0e64c0860dcd80aa0d"` |  |
| container_images.app_goldilocks.goldilocks.image.registry | string | `"gcp.repo.gpkg.io"` |  |
| container_images.app_goldilocks.goldilocks.image.repository | string | `"fairwinds-ops/oss/goldilocks"` |  |
| container_images.app_goldilocks.goldilocks.image.tag | string | `"v4.16.2"` |  |
| container_images.app_ingress_nginx.controller.image.registry | string | `"k8s.repo.gpkg.io"` |  |
| container_images.app_ingress_nginx.controller.image.repository | string | `"ingress-nginx/controller"` |  |
| container_images.app_ingress_nginx.controller.image.tag | string | `"v1.15.1@sha256:594ceea76b01c592858f803f9ff4d2cb40542cae2060410b2c95f75907d659e1"` |  |
| container_images.app_keda.admission_webhooks.image.registry | string | `"ghcr.repo.gpkg.io"` |  |
| container_images.app_keda.admission_webhooks.image.repository | string | `"kedacore/keda-admission-webhooks"` |  |
| container_images.app_keda.admission_webhooks.image.tag | string | `"2.20.2@sha256:41f74102aba7959c6e8d08b433ab8a5fd6cae7c5646c78f7fe3de40a52df3439"` |  |
| container_images.app_keda.keda.image.registry | string | `"ghcr.repo.gpkg.io"` |  |
| container_images.app_keda.keda.image.repository | string | `"kedacore/keda"` |  |
| container_images.app_keda.keda.image.tag | string | `"2.20.2@sha256:fe74c7b8849586a67ad2201bcb89e7f5ac221ff90399ecaa8fd28427f1ef11e6"` |  |
| container_images.app_keda.metrics_apiserver.image.registry | string | `"ghcr.repo.gpkg.io"` |  |
| container_images.app_keda.metrics_apiserver.image.repository | string | `"kedacore/keda-metrics-apiserver"` |  |
| container_images.app_keda.metrics_apiserver.image.tag | string | `"2.20.2@sha256:27286536a8a775aeeee37a7e343f8ecebb27ebf680ee1181a4f99e82eefb253b"` |  |
| container_images.app_kube_prometheus_stack.grafana.image.registry | string | `"dockerhub.repo.gpkg.io"` |  |
| container_images.app_kube_prometheus_stack.grafana.image.repository | string | `"grafana/grafana"` |  |
| container_images.app_kube_prometheus_stack.grafana.image.tag | string | `"10.4.19-security-01@sha256:5584505cb75be8cb14c19d7473a87e2675c68b34b546bc1923ef74300c337111"` |  |
| container_images.app_loki.loki.image.registry | string | `"dockerhub.repo.gpkg.io"` |  |
| container_images.app_loki.loki.image.repository | string | `"grafana/loki"` |  |
| container_images.app_loki.loki.image.tag | string | `"2.9.10@sha256:35b02acc67654ddc38273e519b4f26f3967a907b9db5489af300c21f37ee1ae7"` |  |
| container_images.app_loki_alert_group_controller.loki_alert_group_controller.image.registry | string | `"ghcr.repo.gpkg.io"` |  |
| container_images.app_loki_alert_group_controller.loki_alert_group_controller.image.repository | string | `"glueops/metacontroller-operator-loki-rule-group"` |  |
| container_images.app_loki_alert_group_controller.loki_alert_group_controller.image.tag | string | `"v0.4.6@sha256:61aa2e48fd5c2277551daca68f287e77530a357d280a8199a5db5724b255401c"` |  |
| container_images.app_metacontroller.metacontroller.image.registry | string | `"ghcr.repo.gpkg.io"` |  |
| container_images.app_metacontroller.metacontroller.image.repository | string | `"metacontroller/metacontroller"` |  |
| container_images.app_metacontroller.metacontroller.image.tag | string | `"v4.17.2@sha256:d7a55ebc70b45c2497e9fb5b1d42aae72a8c03545f66a43d9e58583b79cae12d"` |  |
| container_images.app_network_exporter.network_exporter.image.registry | string | `"dockerhub.repo.gpkg.io"` |  |
| container_images.app_network_exporter.network_exporter.image.repository | string | `"syepes/network_exporter"` |  |
| container_images.app_network_exporter.network_exporter.image.tag | string | `"1.8.0@sha256:00af1691570e84bb0d8839d934e1ca10e9ee018385463609e03a8137e0ea9c56"` |  |
| container_images.app_oauth2_proxy.oauth2_proxy.image.registry | string | `"quay.repo.gpkg.io"` |  |
| container_images.app_oauth2_proxy.oauth2_proxy.image.repository | string | `"oauth2-proxy/oauth2-proxy"` |  |
| container_images.app_oauth2_proxy.oauth2_proxy.image.tag | string | `"v7.15.4@sha256:b1b2021fe8f4004573e8d690dec6c7bb29cc44364572cf8510a05bf3a0ae2ded"` |  |
| container_images.app_promtail.promtail.image.registry | string | `"dockerhub.repo.gpkg.io"` |  |
| container_images.app_promtail.promtail.image.repository | string | `"grafana/promtail"` |  |
| container_images.app_promtail.promtail.image.tag | string | `"2.9.10@sha256:63a2e57a5b1401109f77d36a49a637889d431280ed38f5f885eedcd3949e52cf"` |  |
| container_images.app_pull_request_bot.pull_request_bot.image.registry | string | `"ghcr.repo.gpkg.io"` |  |
| container_images.app_pull_request_bot.pull_request_bot.image.repository | string | `"glueops/pull-request-bot"` |  |
| container_images.app_pull_request_bot.pull_request_bot.image.tag | string | `"v2.5.3@sha256:d7853d6d5222e066adfde535418e01b32d07a83eb5945c28245e43d3ac21449f"` |  |
| container_images.app_qr_code_generator.qr_code_generator.image.registry | string | `"ghcr.repo.gpkg.io"` |  |
| container_images.app_qr_code_generator.qr_code_generator.image.repository | string | `"glueops/qr-code-generator"` |  |
| container_images.app_qr_code_generator.qr_code_generator.image.tag | string | `"v2.0.1@sha256:4d3ac7b38661db9ebb87f10f46ca636301570e90c027f217b97c681a0d2825c2"` |  |
| container_images.app_reflector.reflector.image.registry | string | `"dockerhub.repo.gpkg.io"` |  |
| container_images.app_reflector.reflector.image.repository | string | `"emberstack/kubernetes-reflector"` |  |
| container_images.app_reflector.reflector.image.tag | string | `"10.0.65@sha256:51dbd5880929dc26678f6e190c70abfbcccd3846679ff464e5815823fd782f1a"` |  |
| container_images.app_vault.vault.image.registry | string | `"quay.repo.gpkg.io"` |  |
| container_images.app_vault.vault.image.repository | string | `"openbao/openbao"` |  |
| container_images.app_vault.vault.image.tag | string | `"2.6.2@sha256:11fd73a2102cda9c55d5d881a8c3210303146a7ec1e8ac76f526e175c6d24641"` |  |
| container_images.app_vault_init_controller.vault_init_controller.image.registry | string | `"ghcr.repo.gpkg.io"` |  |
| container_images.app_vault_init_controller.vault_init_controller.image.repository | string | `"glueops/vault-init-controller"` |  |
| container_images.app_vault_init_controller.vault_init_controller.image.tag | string | `"v2.14.0@sha256:9b4d6ed77c3843c269846495b3f1f6f20e86cb8c92381727fcfb3d3169b0fbfa"` |  |
| container_images.app_vpa.admission_controller.image.registry | string | `"k8s.repo.gpkg.io"` |  |
| container_images.app_vpa.admission_controller.image.repository | string | `"autoscaling/vpa-admission-controller"` |  |
| container_images.app_vpa.admission_controller.image.tag | string | `"1.7.1@sha256:be29624f7f12a0b6f7fe18e2e042195eb6e39ae37d4490000f2643a480873572"` |  |
| container_images.app_vpa.recommender.image.registry | string | `"k8s.repo.gpkg.io"` |  |
| container_images.app_vpa.recommender.image.repository | string | `"autoscaling/vpa-recommender"` |  |
| container_images.app_vpa.recommender.image.tag | string | `"1.7.1@sha256:89cea705535f9d8df6e62d5084916ec447e85d64369cfff2f7c6ac9d1cc5cd1e"` |  |
| container_images.app_vpa.updater.image.registry | string | `"k8s.repo.gpkg.io"` |  |
| container_images.app_vpa.updater.image.repository | string | `"autoscaling/vpa-updater"` |  |
| container_images.app_vpa.updater.image.tag | string | `"1.7.1@sha256:feb42a5269708d065d5a43c5379d0e4700c3eca333231723d6a7c24f222ab446"` |  |
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
| host_network.external_secrets.webhook_readiness_port | int | `45012` |  |
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
| kubeadm.enabled | string | `"placeholder_enable_kubeadm_cluster"` |  |
| kubeadm.kube_etcd.serviceMonitor.caFile | string | `"/etc/prometheus/secrets/etcd-client-certs/ca.crt"` |  |
| kubeadm.kube_etcd.serviceMonitor.certFile | string | `"/etc/prometheus/secrets/etcd-client-certs/apiserver-etcd-client.crt"` |  |
| kubeadm.kube_etcd.serviceMonitor.keyFile | string | `"/etc/prometheus/secrets/etcd-client-certs/apiserver-etcd-client.key"` |  |
| loki.aws_accessKey | string | `"placeholder_loki_aws_access_key"` | Part of `loki_s3_iam_credentials` output from terraform-module-cloud-multy-prerequisites: https://github.com/GlueOps/terraform-module-cloud-multy-prerequisites |
| loki.aws_region | string | `"placeholder_aws_region"` | Should be the same `primary_region` you used in: https://github.com/GlueOps/terraform-module-cloud-multy-prerequisites |
| loki.aws_secretKey | string | `"placeholder_loki_aws_secret_key"` | Part of `loki_s3_iam_credentials` output from terraform-module-cloud-multy-prerequisites: https://github.com/GlueOps/terraform-module-cloud-multy-prerequisites |
| loki.bucket | string | `"glueops-tenant-placeholder_tenant_key-placeholder_cluster_environment-loki-primary"` | Format: glueops-tenant-placeholder_tenant_key-placeholder_cluster_environment-loki-primary, Credentials found at `loki_credentials` of json output of terraform-module-cloud-multy-prerequisites |
| nginx.controller_replica_count | string | `"placeholder_nginx_controller_replica_count"` | number of replicas for ingress controller |
| nginx.public_lb.enabled | string | `"placeholder_nginx_enable_public_lb"` |  |
| prometheus.volume_claim_storage_request | string | `"placeholder_prometheus_volume_claim_storage_request"` | Volume of storage requested for each Prometheus PVC, in Gi |
| pull_request_bot.watch_for_apps_delay_seconds | string | `"10"` | number of seconds to wait before checking ArgoCD for new applications |
| tls_cert_restore.aws_accessKey | string | `"placeholder_tls_cert_restore_aws_access_key"` | Part of `loki_log_exporter` output from terraform-module-cloud-multy-prerequisites: https://github.com/GlueOps/terraform-module-cloud-multy-prerequisites |
| tls_cert_restore.aws_region | string | `"placeholder_aws_region"` | Should be the same `primary_region` you used in: https://github.com/GlueOps/terraform-module-cloud-multy-prerequisites |
| tls_cert_restore.aws_secretKey | string | `"placeholder_tls_cert_restore_aws_secret_key"` | Part of `loki_log_exporter` output from terraform-module-cloud-multy-prerequisites: https://github.com/GlueOps/terraform-module-cloud-multy-prerequisites |
| tls_cert_restore.backup_prefix | string | `"placeholder_tls_cert_backup_s3_key_prefix"` |  |
| tls_cert_restore.exclude_namespaces | string | `"placeholder_tls_cert_restore_exclude_namespaces"` |  |
| traefik.internal_lb | object | `{"deployment_replicas":"placeholder_traefik_internal_lb_deployment_replicas","enabled":"placeholder_traefik_enable_internal_lb"}` | number of replicas for traefik controller |
| traefik.platform_lb.deployment_replicas | int | `2` |  |
| traefik.public_lb.deployment_replicas | string | `"placeholder_traefik_public_lb_deployment_replicas"` |  |
| traefik.public_lb.enabled | string | `"placeholder_traefik_enable_public_lb"` |  |
| traefik.shared_helm_values.accessLog.enabled | bool | `true` |  |
| traefik.shared_helm_values.accessLog.format | string | `"json"` |  |
| traefik.shared_helm_values.additionalArguments[0] | string | `"--metrics.prometheus=true"` |  |
| traefik.shared_helm_values.additionalArguments[1] | string | `"--metrics.prometheus.addEntryPointsLabels=true"` |  |
| traefik.shared_helm_values.additionalArguments[2] | string | `"--metrics.prometheus.addRoutersLabels=true"` |  |
| traefik.shared_helm_values.additionalArguments[3] | string | `"--metrics.prometheus.addServicesLabels=true"` |  |
| traefik.shared_helm_values.additionalArguments[4] | string | `"--metrics.prometheus.addServicesLabels=true"` |  |
| traefik.shared_helm_values.additionalArguments[5] | string | `"--serversTransport.insecureSkipVerify=true"` |  |
| traefik.shared_helm_values.affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution[0].podAffinityTerm.labelSelector.matchExpressions[0].key | string | `"app.kubernetes.io/name"` |  |
| traefik.shared_helm_values.affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution[0].podAffinityTerm.labelSelector.matchExpressions[0].operator | string | `"In"` |  |
| traefik.shared_helm_values.affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution[0].podAffinityTerm.labelSelector.matchExpressions[0].values[0] | string | `"traefik"` |  |
| traefik.shared_helm_values.affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution[0].podAffinityTerm.topologyKey | string | `"kubernetes.io/hostname"` |  |
| traefik.shared_helm_values.affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution[0].weight | int | `100` |  |
| traefik.shared_helm_values.api.dashboard | bool | `true` |  |
| traefik.shared_helm_values.experimental.plugins.redirectErrors.moduleName | string | `"github.com/indivisible/redirecterrors"` |  |
| traefik.shared_helm_values.experimental.plugins.redirectErrors.version | string | `"v0.1.0"` |  |
| traefik.shared_helm_values.image.registry | string | `"dockerhub.repo.gpkg.io"` |  |
| traefik.shared_helm_values.image.repository | string | `"traefik"` |  |
| traefik.shared_helm_values.image.tag | string | `"v3.7.13@sha256:f86a2cab1b5c649070c49f883c743dd32d8485a56e3368c5f93b9e91f1e91259"` |  |
| traefik.shared_helm_values.log.format | string | `"json"` |  |
| traefik.shared_helm_values.log.level | string | `"INFO"` |  |
| traefik.shared_helm_values.metrics.prometheus.addEntryPointsLabels | bool | `true` |  |
| traefik.shared_helm_values.metrics.prometheus.addRoutersLabels | bool | `true` |  |
| traefik.shared_helm_values.metrics.prometheus.addServicesLabels | bool | `true` |  |
| traefik.shared_helm_values.metrics.prometheus.service.enabled | bool | `true` |  |
| traefik.shared_helm_values.metrics.prometheus.serviceMonitor.enabled | bool | `true` |  |
| traefik.shared_helm_values.ports.traefik.expose.default | bool | `true` |  |
| traefik.shared_helm_values.ports.web.expose.default | bool | `true` |  |
| traefik.shared_helm_values.ports.web.exposedPort | int | `80` |  |
| traefik.shared_helm_values.ports.web.forwardedHeaders.insecure | bool | `true` |  |
| traefik.shared_helm_values.ports.web.transport.lifeCycle.graceTimeOut | string | `"240s"` |  |
| traefik.shared_helm_values.ports.web.transport.lifeCycle.requestAcceptGraceTimeout | string | `"240s"` |  |
| traefik.shared_helm_values.ports.websecure.expose.default | bool | `true` |  |
| traefik.shared_helm_values.ports.websecure.exposedPort | int | `443` |  |
| traefik.shared_helm_values.ports.websecure.forwardedHeaders.insecure | bool | `true` |  |
| traefik.shared_helm_values.ports.websecure.transport.lifeCycle.graceTimeOut | string | `"240s"` |  |
| traefik.shared_helm_values.ports.websecure.transport.lifeCycle.requestAcceptGraceTimeout | string | `"240s"` |  |
| traefik.shared_helm_values.resources.requests.cpu | string | `"100m"` |  |
| traefik.shared_helm_values.resources.requests.memory | string | `"90Mi"` |  |
| traefik.shared_helm_values.tlsStore.default.defaultCertificate.secretName | string | `"default-ingress-cert"` |  |
| vault.data_storage | string | `"placeholder_vault_data_storage"` | Volume of storage requested for each Vault Data PVC, in Gi |
| vault_init_controller.aws_accessKey | string | `"placeholder_vault_init_controller_aws_access_key"` | S3 Credentials to access the vault_access.json |
| vault_init_controller.aws_region | string | `"placeholder_aws_region"` | S3 region to access the vault_access.json |
| vault_init_controller.aws_secretKey | string | `"placeholder_vault_init_controller_aws_access_secret"` | S3 Credentials to access the vault_access.json |
| vault_init_controller.enable_restore | bool | `true` | Enable/Disable restore of an existing backup upon a fresh deployment of vault during cluster bootstrap |
| vault_init_controller.pause_reconcile | bool | `false` | Enable/Disable reconcile |
| vault_init_controller.reconcile_period | int | `30` | How often the controller should run |
| vault_init_controller.s3_bucket_name | string | `"placeholder_tenant_s3_multi_region_access_point"` | S3 bucket that will store the vault unseal key(s) and root token |
| vault_init_controller.s3_key_path | string | `"placeholder_vault_init_controller_s3_key"` | S3 key/path to the unseal key(s) and root token |
