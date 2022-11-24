# platform


This repo is to be used as a helm chart within the context of ArgoCD. Within the templates directory we have a number of different ArgoCD Application definitions. Some of the applications have depencies between each other and to account for this we use sync-wave annotations. ref: https://argo-cd.readthedocs.io/en/stable/user-guide/sync-waves/#how-do-i-configure-waves

This helm chart deploys the core of the GlueOps platform. Everything here is expected to be deployed by default onto a new kubernetes cluster.
