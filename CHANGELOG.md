# Changelog

## [0.79.0](https://github.com/GlueOps/platform-helm-chart-platform/compare/v0.78.0...v0.79.0) (2026-09-05)


### Features

* let the argocd and bao CLIs authenticate through oauth2-proxy ([#1485](https://github.com/GlueOps/platform-helm-chart-platform/issues/1485)) ([15b7b98](https://github.com/GlueOps/platform-helm-chart-platform/commit/15b7b989f118919fcb690b80af2bc957eb1e110a))

## [0.78.0](https://github.com/GlueOps/platform-helm-chart-platform/compare/v0.77.0...v0.78.0) (2026-08-28)


### ⚠ BREAKING CHANGES

* this release must only be deployed after `captain_utils -> crds` has applied the platform-crds bundle on the cluster (plan section 7); on a cluster without the bundle the flipped Applications would leave their CRDs unmanaged and new clusters would have no CRDs at all. Argo CD 3.2.12 never tracked these CRDs, so on migrated clusters the flag flips are non-destructive (no prune).

### Features

* stop rendering CRDs in ArgoCD Applications (CRDs come from the platform-crds bundle) ([#1480](https://github.com/GlueOps/platform-helm-chart-platform/issues/1480)) ([19cb19b](https://github.com/GlueOps/platform-helm-chart-platform/commit/19cb19b1238e106a3f92cb6913344b9c0713c04f))

## [0.77.0](https://github.com/GlueOps/platform-helm-chart-platform/compare/v0.76.0...v0.77.0) (2026-08-03)


### Features

* update glueops/vault-init-controller to v2.14.0 #minor ([#1475](https://github.com/GlueOps/platform-helm-chart-platform/issues/1475)) ([39c1697](https://github.com/GlueOps/platform-helm-chart-platform/commit/39c1697132e95562c1c5f26ef83bb2f2c8caf7e0))


### Miscellaneous Chores

* add Apache-2.0 LICENSE ([#1473](https://github.com/GlueOps/platform-helm-chart-platform/issues/1473)) ([2f6525c](https://github.com/GlueOps/platform-helm-chart-platform/commit/2f6525c5f4d9bdf124d3dc79068ffd037e2f6054))

## [0.76.0](https://github.com/GlueOps/platform-helm-chart-platform/compare/v0.75.4...v0.76.0) (2026-07-25)


### Features

* update keda to 2.20.1 #minor ([#1459](https://github.com/GlueOps/platform-helm-chart-platform/issues/1459)) ([81469d7](https://github.com/GlueOps/platform-helm-chart-platform/commit/81469d7b04680e69f83b6352ba47acb921958b6f))


### Bug Fixes

* remove LowNodeUtilization from descheduler ([#1472](https://github.com/GlueOps/platform-helm-chart-platform/issues/1472)) ([21a5bae](https://github.com/GlueOps/platform-helm-chart-platform/commit/21a5baeb4d807c2c261c6aae546e203561e42add))

## [0.75.4](https://github.com/GlueOps/platform-helm-chart-platform/compare/v0.75.3...v0.75.4) (2026-07-23)


### Bug Fixes

* removing limits from vpa ([#1469](https://github.com/GlueOps/platform-helm-chart-platform/issues/1469)) ([ffafd24](https://github.com/GlueOps/platform-helm-chart-platform/commit/ffafd242ef57d0831f7cfe319667e000af64d132))

## [0.75.3](https://github.com/GlueOps/platform-helm-chart-platform/compare/v0.75.2...v0.75.3) (2026-07-23)


### Bug Fixes

* **goldilocks:** using chart defaults instead of overrides. ([#1468](https://github.com/GlueOps/platform-helm-chart-platform/issues/1468)) ([8cf5ba4](https://github.com/GlueOps/platform-helm-chart-platform/commit/8cf5ba429bcdba6812b864855e6465cde50eca99))
* Update goldilocks dashboard memory limit ([#1466](https://github.com/GlueOps/platform-helm-chart-platform/issues/1466)) ([11f1c24](https://github.com/GlueOps/platform-helm-chart-platform/commit/11f1c241895618f7034473d8e9f8ce593ab6a30a))

## [0.75.2](https://github.com/GlueOps/platform-helm-chart-platform/compare/v0.75.1...v0.75.2) (2026-07-10)


### Bug Fixes

* namespacing of vpa/goldilocks to be prefixed with glueops-core-* ([#1457](https://github.com/GlueOps/platform-helm-chart-platform/issues/1457)) ([7150dc0](https://github.com/GlueOps/platform-helm-chart-platform/commit/7150dc0f2e1634241748a34410a428760f6f458e))

## [0.75.1](https://github.com/GlueOps/platform-helm-chart-platform/compare/v0.75.0...v0.75.1) (2026-07-10)


### Bug Fixes

* sizing of cards on cluster-info page ([#1455](https://github.com/GlueOps/platform-helm-chart-platform/issues/1455)) ([c7f0dc4](https://github.com/GlueOps/platform-helm-chart-platform/commit/c7f0dc4c695b835a954180558d6c30c7073f02ad))

## [0.75.0](https://github.com/GlueOps/platform-helm-chart-platform/compare/v0.74.0...v0.75.0) (2026-07-10)


### Features

* update ghcr.repo.gpkg.io/glueops/cluster-information-help-page-html to v4.30.1 #minor ([#1447](https://github.com/GlueOps/platform-helm-chart-platform/issues/1447)) ([70577af](https://github.com/GlueOps/platform-helm-chart-platform/commit/70577aff9d0e85f8d5090782728d36a04f7689df))
* update oauth2-proxy to 10.7.0 #minor ([26f7cf6](https://github.com/GlueOps/platform-helm-chart-platform/commit/26f7cf610a0821b807acec44586a17ac620d2376))


### Bug Fixes

* goldilocks.enabled -&gt; kubeadm.enabled ([fc44426](https://github.com/GlueOps/platform-helm-chart-platform/commit/fc44426e71aa6c9845266f926812807e69beefea))
* pin openbao podManagementPolicy for HA raft, use ghcr mirror ([#1441](https://github.com/GlueOps/platform-helm-chart-platform/issues/1441)) ([c2c3456](https://github.com/GlueOps/platform-helm-chart-platform/commit/c2c3456cb80409b3b53b1f3c806227273489e6ef))
* remove unused goldilocks placeholder since we are using the same gate as kubeadm now ([1b0b5c4](https://github.com/GlueOps/platform-helm-chart-platform/commit/1b0b5c400707e0ef4acf3c701b4cd8f1636f5da3))
* trigger new release ([#1452](https://github.com/GlueOps/platform-helm-chart-platform/issues/1452)) ([63e5c99](https://github.com/GlueOps/platform-helm-chart-platform/commit/63e5c99467a6df77ea42e2391ad80cbae5488123))


### Reverts

* 6fbcdd6a0510e5287bb67ff461d361aead866843 https://github.com/GlueOps/platform-helm-chart-platform/pull/1300  ([ea2350c](https://github.com/GlueOps/platform-helm-chart-platform/commit/ea2350c9a4f707d74d7dfbdb88a7f9535d050caa))
* 70708dc8a28efe948099b022faed2c44c480549a  https://github.com/GlueOps/platform-helm-chart-platform/pull/1297 ([ea2350c](https://github.com/GlueOps/platform-helm-chart-platform/commit/ea2350c9a4f707d74d7dfbdb88a7f9535d050caa))
* prs - keda https://github.com/GlueOps/platform-helm-chart-platform/pull/1300  & nginx - https://github.com/GlueOps/platform-helm-chart-platform/pull/1297 ([ea2350c](https://github.com/GlueOps/platform-helm-chart-platform/commit/ea2350c9a4f707d74d7dfbdb88a7f9535d050caa))


### Miscellaneous Chores

* **main:** release 0.74.0 ([#1385](https://github.com/GlueOps/platform-helm-chart-platform/issues/1385)) ([9710167](https://github.com/GlueOps/platform-helm-chart-platform/commit/97101670f0489d8d187cb67a67d82a84cab414a8))

## [0.74.0](https://github.com/GlueOps/platform-helm-chart-platform/compare/v0.73.1...v0.74.0) (2026-07-10)


### ⚠ BREAKING CHANGES

* after upgrading, and before the follow-up release deletes this Application, verify it has no finalizer — otherwise the delete cascades and wipes the kube-prometheus-stack CRDs and all monitoring CRs. Verify with `kubectl get application kube-prometheus-stack-crds -n glueops-core -o jsonpath='{.metadata.finalizers}'` and expect empty output; if it is non-empty, strip it first with `kubectl patch application kube-prometheus-stack-crds -n glueops-core --type merge -p '{"metadata":{"finalizers":null}}'`.

### Features

* add vpa & goldilocks ([#1387](https://github.com/GlueOps/platform-helm-chart-platform/issues/1387)) ([bdf230e](https://github.com/GlueOps/platform-helm-chart-platform/commit/bdf230e14deeeac321b0071a4f4b09746c99b148))
* de-fang kube-prometheus-stack-crds app ahead of its removal ([cf96a1c](https://github.com/GlueOps/platform-helm-chart-platform/commit/cf96a1c61c12e30e075bc31f1236cb2a5fe41d41))
* update app to 0.13.0 #minor ([317862f](https://github.com/GlueOps/platform-helm-chart-platform/commit/317862ff8d3b559c6a1ccfc77e4ae469dd188936))
* update ghcr.repo.gpkg.io/glueops/backup-tools to v2.15.0 #minor ([#1375](https://github.com/GlueOps/platform-helm-chart-platform/issues/1375)) ([e88c69e](https://github.com/GlueOps/platform-helm-chart-platform/commit/e88c69eb9d853c1814928df85d18e874df6284ce))
* update ghcr.repo.gpkg.io/glueops/cluster-information-help-page-html to v4.28.0 #minor ([#1376](https://github.com/GlueOps/platform-helm-chart-platform/issues/1376)) ([036ff88](https://github.com/GlueOps/platform-helm-chart-platform/commit/036ff8881b66bfe31384f2d46d07efb45c8ce7b8))
* update ghcr.repo.gpkg.io/glueops/cluster-information-help-page-html to v4.30.1 #minor ([#1447](https://github.com/GlueOps/platform-helm-chart-platform/issues/1447)) ([70577af](https://github.com/GlueOps/platform-helm-chart-platform/commit/70577aff9d0e85f8d5090782728d36a04f7689df))
* update ghcr.repo.gpkg.io/glueops/gluekube-ccm to v0.43.0 #minor ([#1368](https://github.com/GlueOps/platform-helm-chart-platform/issues/1368)) ([333d6b3](https://github.com/GlueOps/platform-helm-chart-platform/commit/333d6b39ee524133fcd18a21636f4b3b4de1931f))
* update ghcr.repo.gpkg.io/glueops/go-healthz to v0.2.1 #minor ([#1373](https://github.com/GlueOps/platform-helm-chart-platform/issues/1373)) ([c96724d](https://github.com/GlueOps/platform-helm-chart-platform/commit/c96724dbd615dad5d15d146191c50b14589d8bdb))
* update ghcr.repo.gpkg.io/glueops/pull-request-bot to v2.5.3 #minor ([#1364](https://github.com/GlueOps/platform-helm-chart-platform/issues/1364)) ([df6d44c](https://github.com/GlueOps/platform-helm-chart-platform/commit/df6d44c0b71f8ad97789d71ce87b532683b8761e))
* update ghcr.repo.gpkg.io/glueops/vault-backup-validator to v2.18.0 #minor ([#1377](https://github.com/GlueOps/platform-helm-chart-platform/issues/1377)) ([2c09699](https://github.com/GlueOps/platform-helm-chart-platform/commit/2c096991701235fd51364ad9e10e99b44f61e0a6))
* update ghcr.repo.gpkg.io/glueops/vault-init-controller to v2.13.1 #minor ([#1374](https://github.com/GlueOps/platform-helm-chart-platform/issues/1374)) ([1098449](https://github.com/GlueOps/platform-helm-chart-platform/commit/109844954dad0d63e48d4648c242f128989dcd2e))
* update ingress-nginx to 4.15.1 #minor ([#1297](https://github.com/GlueOps/platform-helm-chart-platform/issues/1297)) ([70708dc](https://github.com/GlueOps/platform-helm-chart-platform/commit/70708dc8a28efe948099b022faed2c44c480549a))
* update keda to 2.19.0 #minor ([#1300](https://github.com/GlueOps/platform-helm-chart-platform/issues/1300)) ([6fbcdd6](https://github.com/GlueOps/platform-helm-chart-platform/commit/6fbcdd6a0510e5287bb67ff461d361aead866843))
* update kubernetes-sigs/descheduler to v0.36.0 #minor ([#1360](https://github.com/GlueOps/platform-helm-chart-platform/issues/1360)) ([0d669c5](https://github.com/GlueOps/platform-helm-chart-platform/commit/0d669c543b3967029fdc845d5fc5649ddfc9ffec))
* update oauth2-proxy to 10.7.0 #minor ([26f7cf6](https://github.com/GlueOps/platform-helm-chart-platform/commit/26f7cf610a0821b807acec44586a17ac620d2376))


### Bug Fixes

* collapse Renovate per-minor PR sprawl ([#1437](https://github.com/GlueOps/platform-helm-chart-platform/issues/1437)) ([b4d48c5](https://github.com/GlueOps/platform-helm-chart-platform/commit/b4d48c5dc563a659be9fb725aab3af4672c0a9e6))
* goldilocks.enabled -&gt; kubeadm.enabled ([fc44426](https://github.com/GlueOps/platform-helm-chart-platform/commit/fc44426e71aa6c9845266f926812807e69beefea))
* pin openbao podManagementPolicy for HA raft, use ghcr mirror ([#1441](https://github.com/GlueOps/platform-helm-chart-platform/issues/1441)) ([c2c3456](https://github.com/GlueOps/platform-helm-chart-platform/commit/c2c3456cb80409b3b53b1f3c806227273489e6ef))
* remove unused goldilocks placeholder since we are using the same gate as kubeadm now ([1b0b5c4](https://github.com/GlueOps/platform-helm-chart-platform/commit/1b0b5c400707e0ef4acf3c701b4cd8f1636f5da3))
* removed "RemoveDuplicates" ([#1383](https://github.com/GlueOps/platform-helm-chart-platform/issues/1383)) ([3a4323b](https://github.com/GlueOps/platform-helm-chart-platform/commit/3a4323ba8bec6dc901ff2591f41f8fddfd974b4b))


### Reverts

* 6fbcdd6a0510e5287bb67ff461d361aead866843 https://github.com/GlueOps/platform-helm-chart-platform/pull/1300  ([ea2350c](https://github.com/GlueOps/platform-helm-chart-platform/commit/ea2350c9a4f707d74d7dfbdb88a7f9535d050caa))
* 70708dc8a28efe948099b022faed2c44c480549a  https://github.com/GlueOps/platform-helm-chart-platform/pull/1297 ([ea2350c](https://github.com/GlueOps/platform-helm-chart-platform/commit/ea2350c9a4f707d74d7dfbdb88a7f9535d050caa))
* prs - keda https://github.com/GlueOps/platform-helm-chart-platform/pull/1300  & nginx - https://github.com/GlueOps/platform-helm-chart-platform/pull/1297 ([ea2350c](https://github.com/GlueOps/platform-helm-chart-platform/commit/ea2350c9a4f707d74d7dfbdb88a7f9535d050caa))


### Miscellaneous Chores

* **patch:** update dex to 0.24.1 #patch ([#1370](https://github.com/GlueOps/platform-helm-chart-platform/issues/1370)) ([b1d761d](https://github.com/GlueOps/platform-helm-chart-platform/commit/b1d761d0779f41f6c89692a2468dcf9b01b88dfa))
* **patch:** update oauth2-proxy to 9.0.1 #patch ([75d9b04](https://github.com/GlueOps/platform-helm-chart-platform/commit/75d9b048befe4d5418451d875357d8acea48e281))
* remove unused variables for image app_glueops_alerts since it's been migrated to a manifest app ([44af1d0](https://github.com/GlueOps/platform-helm-chart-platform/commit/44af1d09118847be738d870e1196b6e996bf5a23))
* update oauth2-proxy image v7.13.0 -&gt; v7.15.3 ([3ee4694](https://github.com/GlueOps/platform-helm-chart-platform/commit/3ee4694920e653154e4660936a93feea4adb59d1))

## [0.73.1](https://github.com/GlueOps/platform-helm-chart-platform/compare/v0.73.0...v0.73.1) (2026-07-01)


### Continuous Integration

* fix OCI push URL missing the ghcr.io registry host ([3a9b798](https://github.com/GlueOps/platform-helm-chart-platform/commit/3a9b79842a34dd478ef73b1c7f3558770ccdb0de))

## [0.73.0](https://github.com/GlueOps/platform-helm-chart-platform/compare/v0.72.0...v0.73.0) (2026-07-01)


### Features

* enable traefik to support allowExternalNameServices ([2d99ac1](https://github.com/GlueOps/platform-helm-chart-platform/commit/2d99ac18c96dc5e6e584f4a01c5d0d726bda6f78))


### Bug Fixes

* **renovate:** match registry-qualified image names for ignored values.yaml images ([#1372](https://github.com/GlueOps/platform-helm-chart-platform/issues/1372)) ([7600e60](https://github.com/GlueOps/platform-helm-chart-platform/commit/7600e607d3df749cc77812f2695c0bc3a1edc582))


### Miscellaneous Chores

* ignore Renovate updates for platform-managed monitoring/logging apps ([#1371](https://github.com/GlueOps/platform-helm-chart-platform/issues/1371)) ([b2ab4bf](https://github.com/GlueOps/platform-helm-chart-platform/commit/b2ab4bf3fe156b0524d784bc67a2b3a92b199371))


### Continuous Integration

* add release-please with release-time doc generation ([8b9dfa0](https://github.com/GlueOps/platform-helm-chart-platform/commit/8b9dfa05cc87640e0e22f8ee414771621e4366e8))
* publish the chart to GHCR as an OCI artifact ([8c7961c](https://github.com/GlueOps/platform-helm-chart-platform/commit/8c7961cefd3b203e9d58f5ec2b150ec1e8a5241c))
