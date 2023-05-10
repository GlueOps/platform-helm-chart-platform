Below will is an example of how to generate the helm values for the platform helm chart

```hcl
module "glueops_platform_helm_values" {
  source                       = "git::https://github.com/GlueOps/platform-helm-chart-platform.git//terraform-to-generate-values"
  dex_github_client_id         = "43570a74c8bfc85da6b0"
  dex_github_client_secret     = "9f583c64f841e84e634468214bb0c0b4748dca7c"
  dex_argocd_client_secret     = "Zsbui/29YEqoGOzuI8snlqGcdaRYPSLocwLXDB5GhZY="
  dex_grafana_client_secret    = "AyYzghXw/qn/zfO6j9tN4H/7yLSYFPqnKOeoXOSi5U0="
  dex_vault_client_secret      = "aLCZg513OvIA0vY5c24KLU2PrRXmBdhLGLUBrpkhBmE="
  dex_pomerium_client_secret   = "5yon23Cwa83fscaq/CPTZ8UdhYIJ7gfHnl+gQO+FfPk="
  vault_aws_access_key         = "AKIAU5Q3HAEIVOZFADIL"
  vault_aws_secret_key         = "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"
  loki_aws_access_key          = "AKIAA5QFHEEIFO6FYDE7"
  loki_aws_secret_key          = "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"
  loki_exporter_aws_access_key = "AKIAU5Q3FAEITB7FKDHC"
  loki_exporter_aws_secret_key = "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"
  certmanager_aws_access_key   = "AKIAU5Q3HGAFQKZHSDOY"
  certmanager_aws_secret_key   = "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"
  externaldns_aws_access_key   = "AKIAU5E3HAEIVOZ7FDIL"
  externaldns_aws_secret_key   = "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"
  glueops_root_domain          = "onglueops.com"
  cluster_environment          = "nonprod"
  aws_region                   = "us-west-2"
  tenant_key                   = "antoniostacos"
  opsgenie_api_key             = "508e9ab8-dbe1-4cef-85f0-f24d1a2633bc"
}

output "glueops_platform_helm_values" {
    value = module.glueops_platform_helm_values.helm_values
}
```