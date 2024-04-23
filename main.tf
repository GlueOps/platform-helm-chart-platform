terraform {
  required_providers {
    http = {
      source = "hashicorp/http"
    }
    local = {
      source = "hashicorp/local"
    }
  }
}

variable "opsgenie_api_key" {
  description = "Opsgenie API key"
}

variable "aws_region" {
  description = "AWS region"
}

variable "vault_aws_access_key" {
  description = "AWS access key for Vault"
}

variable "vault_aws_secret_key" {
  description = "AWS secret key for Vault"
}

variable "loki_exporter_aws_access_key" {
  description = "AWS access key for Loki exporter"
}

variable "loki_exporter_aws_secret_key" {
  description = "AWS secret key for Loki exporter"
}

variable "fluentbit_exporter_aws_access_key" {
  description = "AWS access key for FluentBit exporter"
}

variable "fluentbit_exporter_aws_secret_key" {
  description = "AWS secret key for FluentBit exporter"
}

variable "externaldns_aws_access_key" {
  description = "AWS access key for external DNS"
}

variable "externaldns_aws_secret_key" {
  description = "AWS secret key for external DNS"
}

variable "certmanager_aws_access_key" {
  description = "AWS access key for cert manager"
}

variable "certmanager_aws_secret_key" {
  description = "AWS secret key for cert manager"
}

variable "loki_aws_access_key" {
  description = "AWS access key for Loki"
}

variable "loki_aws_secret_key" {
  description = "AWS secret key for Loki"
}

variable "dex_github_client_id" {
  description = "Dex GitHub client ID"
}

variable "dex_github_client_secret" {
  description = "Dex GitHub client secret"
}

variable "dex_argocd_client_secret" {
  description = "Dex Argocd client secret"
}

variable "dex_grafana_client_secret" {
  description = "Dex Grafana client secret"
}

variable "dex_pomerium_client_secret" {
  description = "Dex Pomerium client secret"
}

variable "dex_vault_client_secret" {
  description = "Dex Vault client secret"
}

variable "tenant_key" {
  type        = string
  description = "this is also known as the tenant name or company key"
}

variable "glueops_root_domain" {
  type        = string
  description = "this is the root domain for the glueops platform (e.g. onglueops.rocks, onglueops.com, etc.))"
}

variable "cluster_environment" {
  type        = string
  description = "this is the cluster environment name (e.g. dev, staging, prod, nonprod, uswestprod, etc.))"
}

variable "this_is_development" {
  type        = bool
  description = "Determines whether the cluster is a development cluster or deployed in a customer environment."
}

variable "host_network_enabled" {
  type        = bool
  description = "Determines whether or not to use hostNetwork mode."
}



data "local_file" "platform_values_template" {
  filename = "${path.module}/values.yaml"
}

variable "admin_github_org_name" {
  description = "Admin GitHub org name"
  default     = "GlueOps"
  type        = string
  nullable    = true
}

variable "tenant_github_org_name" {
  description = "Tenant GitHub org name"
  default     = "glueops-rocks"
  type        = string
  nullable    = true
}

variable "grafana_admin_password" {
  description = "Grafana admin password"
  default     = "supersecret1234"
  type        = string
  nullable    = true
}

variable "github_tenant_app_id" {
  description = "GitHub App ID"
  type        = string
  nullable    = false
}

variable "github_tenant_app_installation_id" {
  description = "GitHub App Installation ID"
  type        = string
  nullable    = false
}

variable "github_tenant_app_b64enc_private_key" {
  description = "GitHub App Private Key, base64 encoded"
  type        = string
  nullable    = false
}

variable "captain_repo_b64encoded_private_deploy_key" {
  description = "Captain repo private deploy key, base64 encoded"
  type        = string
  nullable    = false
}

variable "captain_repo_ssh_clone_url" {
  description = "Captain repo SSH clone URL"
  type        = string
  nullable    = false
}


variable "vault_init_controller_s3_key" {
  description = "Vault Init Controller S3 key path that has the vault creds"
  type        = string
  nullable    = false
}

variable "vault_init_controller_aws_access_key" {
  description = "Vault Init Controller S3 creds"
  type        = string
  nullable    = false
}

variable "vault_init_controller_aws_access_secret" {
  description = "Vault Init Controller S3 creds"
  type        = string
  nullable    = false
}

variable "glueops_operators_waf_aws_access_key" {
  description = "GlueOps Metacontroller Operator AWS WAF Credentials"
  type        = string
  nullable    = false
}

variable "glueops_operators_waf_aws_secret_key" {
  description = "GlueOps Metacontroller Operator AWS WAF Credentials"
  type        = string
  nullable    = false
}

variable "glueops_operators_web_acl_aws_access_key" {
  description = "GlueOps Metacontroller Operator AWS WebACL Credentials"
  type        = string
  nullable    = false
}
variable "glueops_operators_web_acl_aws_secret_key" {
  description = "GlueOps Metacontroller Operator AWS WebACL Credentials"
  type        = string
  nullable    = false
}



output "helm_values" {
  value = replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(
    replace(replace(replace(
      data.local_file.platform_values_template.content,
    "placeholder_tenant_key", var.tenant_key),
    "placeholder_captain_repo_b64enc_private_deploy_key", var.captain_repo_b64encoded_private_deploy_key),
    "placeholder_captain_repo_ssh_clone_url", var.captain_repo_ssh_clone_url),
    "placeholder_this_is_development", var.this_is_development),
    "placeholder_enable_host_network", var.host_network_enabled),
    "placeholder_cluster_environment", var.cluster_environment),
    "placeholder_glueops_root_domain", var.glueops_root_domain),
    "placeholder_opsgenie_api_key", var.opsgenie_api_key),
    "placeholder_aws_region", var.aws_region),
    "placeholder_vault_aws_access_key", var.vault_aws_access_key),
    "placeholder_vault_aws_secret_key", var.vault_aws_secret_key),
    "placeholder_loki_exporter_aws_access_key", var.loki_exporter_aws_access_key),
    "placeholder_loki_exporter_aws_secret_key", var.loki_exporter_aws_secret_key),
    "placeholder_fluentbit_exporter_aws_access_key", var.fluentbit_exporter_aws_access_key),
    "placeholder_fluentbit_exporter_aws_secret_key", var.fluentbit_exporter_aws_secret_key),
    "placeholder_externaldns_aws_access_key", var.externaldns_aws_access_key),
    "placeholder_externaldns_aws_secret_key", var.externaldns_aws_secret_key),
    "placeholder_certmanager_aws_access_key", var.certmanager_aws_access_key),
    "placeholder_certmanager_aws_secret_key", var.certmanager_aws_secret_key),
    "placeholder_loki_aws_access_key", var.loki_aws_access_key),
    "placeholder_loki_aws_secret_key", var.loki_aws_secret_key),
    "placeholder_dex_github_client_id", var.dex_github_client_id),
    "placeholder_dex_github_client_secret", var.dex_github_client_secret),
    "placeholder_dex_argocd_client_secret", var.dex_argocd_client_secret),
    "placeholder_dex_grafana_client_secret", var.dex_grafana_client_secret),
    "placeholder_dex_pomerium_client_secret", var.dex_pomerium_client_secret),
    "placeholder_dex_vault_client_secret", var.dex_vault_client_secret),
    "placeholder_admin_github_org_name", var.admin_github_org_name),
    "placeholder_tenant_github_org_name", var.tenant_github_org_name),
    "placeholder_grafana_admin_password", var.grafana_admin_password),
    "placeholder_github_tenant_app_id", var.github_tenant_app_id),
    "placeholder_github_tenant_app_installation_id", var.github_tenant_app_installation_id),
    "placeholder_github_tenant_app_b64enc_private_key", var.github_tenant_app_b64enc_private_key),
    "placeholder_vault_init_controller_s3_key", var.vault_init_controller_s3_key),
    "placeholder_vault_init_controller_aws_access_key", var.vault_init_controller_aws_access_key),
    "placeholder_vault_init_controller_aws_access_secret", var.vault_init_controller_aws_access_secret),
    "placeholder_glueops_operators_waf_aws_access_key", var.glueops_operators_waf_aws_access_key),
    "placeholder_glueops_operators_waf_aws_secret_key", var.glueops_operators_waf_aws_secret_key),
    "placeholder_glueops_operators_web_acl_aws_access_key", var.glueops_operators_web_acl_aws_access_key),
  "placeholder_glueops_operators_web_acl_aws_secret_key", var.glueops_operators_web_acl_aws_secret_key)

}
