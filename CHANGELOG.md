# Changelog

## [0.84.0](https://github.com/GlueOps/platform-helm-chart-platform/compare/v0.83.0...v0.84.0) (2026-11-10)


### Features

* spread inventory-agent POSTs with a random start delay ([#1616](https://github.com/GlueOps/platform-helm-chart-platform/issues/1616)) ([b6fd9ed](https://github.com/GlueOps/platform-helm-chart-platform/commit/b6fd9ed1894c7f30d56488c4c12b264ee576350a))

## [0.83.0](https://github.com/GlueOps/platform-helm-chart-platform/compare/v0.82.0...v0.83.0) (2026-11-03)


### Features

* **deps:** update actions/checkout action to v7 ([#1462](https://github.com/GlueOps/platform-helm-chart-platform/issues/1462)) ([3a0f54f](https://github.com/GlueOps/platform-helm-chart-platform/commit/3a0f54fd7ac0f13a5414ca9dc60ced94a3ebcbc4))
* **deps:** update actions/create-github-app-token action to v3.3.0 ([#1597](https://github.com/GlueOps/platform-helm-chart-platform/issues/1597)) ([844f46e](https://github.com/GlueOps/platform-helm-chart-platform/commit/844f46effcc8a75f78e5d00d4c7ab25e4ae7d1d2))
* **deps:** update dependency helm to v3.21.4 ([#1564](https://github.com/GlueOps/platform-helm-chart-platform/issues/1564)) ([fe7cef6](https://github.com/GlueOps/platform-helm-chart-platform/commit/fe7cef6629e65d905fe9c95638bb57616e417495))
* **deps:** update dependency kubernetes-sigs/descheduler to v0.37.0 ([#1598](https://github.com/GlueOps/platform-helm-chart-platform/issues/1598)) ([514d553](https://github.com/GlueOps/platform-helm-chart-platform/commit/514d5536f642364e6db21093e58fd71e0dcb2d40))
* **deps:** update dependency kubernetes-sigs/external-dns to v1.23.0 ([#1592](https://github.com/GlueOps/platform-helm-chart-platform/issues/1592)) ([0205da7](https://github.com/GlueOps/platform-helm-chart-platform/commit/0205da75c58107524255ee8cbfa92cb965bb8768))
* **deps:** update dockerhub.repo.gpkg.io/curlimages/curl docker tag to v8.23.0 ([#1557](https://github.com/GlueOps/platform-helm-chart-platform/issues/1557)) ([e3221ce](https://github.com/GlueOps/platform-helm-chart-platform/commit/e3221ce890896a8e52de636e52378ea7a7095244))
* **deps:** update external-secrets docker tag to v2.14.0 ([#1578](https://github.com/GlueOps/platform-helm-chart-platform/issues/1578)) ([5e361b1](https://github.com/GlueOps/platform-helm-chart-platform/commit/5e361b1ae5bf778f4a066bfd799a7f991ebc9809))
* **deps:** update ghcr.repo.gpkg.io/external-secrets/external-secrets docker tag to v2.14.0 ([#1577](https://github.com/GlueOps/platform-helm-chart-platform/issues/1577)) ([a79e333](https://github.com/GlueOps/platform-helm-chart-platform/commit/a79e333d0a349baba1f634ea4798f00e70409424))
* **deps:** update helm release app to v0.17.1 ([#1556](https://github.com/GlueOps/platform-helm-chart-platform/issues/1556)) ([5b1651d](https://github.com/GlueOps/platform-helm-chart-platform/commit/5b1651d8a7f2ef699cdc124704a0d6a0ac613abb))
* **deps:** update helm release dex to v0.26.0 ([#1599](https://github.com/GlueOps/platform-helm-chart-platform/issues/1599)) ([7717b9f](https://github.com/GlueOps/platform-helm-chart-platform/commit/7717b9fc65390e99f9596df30101c10933c0cf08))
* **deps:** update helm release goldilocks to v11.2.0 ([#1586](https://github.com/GlueOps/platform-helm-chart-platform/issues/1586)) ([5d6b852](https://github.com/GlueOps/platform-helm-chart-platform/commit/5d6b85286a78499bf7d5249706f37e608f3ebd09))
* **deps:** update helm release traefik to v42 ([#1601](https://github.com/GlueOps/platform-helm-chart-platform/issues/1601)) ([fef4c73](https://github.com/GlueOps/platform-helm-chart-platform/commit/fef4c739bd9ac12f0975b12033ea694b39411f8a))
* **deps:** update k8s.repo.gpkg.io/descheduler/descheduler docker tag to v0.37.0 ([#1569](https://github.com/GlueOps/platform-helm-chart-platform/issues/1569)) ([abd1525](https://github.com/GlueOps/platform-helm-chart-platform/commit/abd1525adbac70e440219c0586e12459345a973b))
* **deps:** update k8s.repo.gpkg.io/external-dns/external-dns docker tag to v0.24.0 ([#1576](https://github.com/GlueOps/platform-helm-chart-platform/issues/1576)) ([9bdb763](https://github.com/GlueOps/platform-helm-chart-platform/commit/9bdb7630a5f5fa447178a686046f3a5f879e2091))
* **deps:** update openbao docker tag to v0.30.6 ([#1571](https://github.com/GlueOps/platform-helm-chart-platform/issues/1571)) ([43944b7](https://github.com/GlueOps/platform-helm-chart-platform/commit/43944b79a7514ac547f3f6da46736f03d1d47c43))


### Bug Fixes

* **hooks:** delete health-check hook jobs after they finish ([#1594](https://github.com/GlueOps/platform-helm-chart-platform/issues/1594)) ([8b0ffd4](https://github.com/GlueOps/platform-helm-chart-platform/commit/8b0ffd45b40313b8e4a32b9969a37acb6587e100))


### Dependencies

* pin dependencies ([#1258](https://github.com/GlueOps/platform-helm-chart-platform/issues/1258)) ([94ccce5](https://github.com/GlueOps/platform-helm-chart-platform/commit/94ccce524f65f7839d009a61c72633926960ea01))
* update actions/checkout digest to d23441a ([#1464](https://github.com/GlueOps/platform-helm-chart-platform/issues/1464)) ([12e9c84](https://github.com/GlueOps/platform-helm-chart-platform/commit/12e9c8406c225ae10eea074a01245ab824c8c03d))
* update dependency https://github.com/metacontroller/metacontroller.git to v4.17.6 ([#1547](https://github.com/GlueOps/platform-helm-chart-platform/issues/1547)) ([7980d85](https://github.com/GlueOps/platform-helm-chart-platform/commit/7980d85c6cf8f40b5c47b15bf9dfd32d7366f05b))
* update dockerhub.repo.gpkg.io/emberstack/kubernetes-reflector docker tag to v10.0.71 ([#1587](https://github.com/GlueOps/platform-helm-chart-platform/issues/1587)) ([cf488f8](https://github.com/GlueOps/platform-helm-chart-platform/commit/cf488f8541e59ea1e0c9f6425c2d362987ef4a20))
* update dockerhub.repo.gpkg.io/traefik docker tag to v3.7.17 ([#1545](https://github.com/GlueOps/platform-helm-chart-platform/issues/1545)) ([b3be1ae](https://github.com/GlueOps/platform-helm-chart-platform/commit/b3be1ae694304a5031c049b1e232d2cdbd7bda5d))
* update ghcr.repo.gpkg.io/metacontroller/metacontroller docker tag to v4.17.6 ([#1546](https://github.com/GlueOps/platform-helm-chart-platform/issues/1546)) ([365e194](https://github.com/GlueOps/platform-helm-chart-platform/commit/365e1941391dd1c73212aa912d51fdfcb1887913))
* update helm release oauth2-proxy to v10.7.1 ([#1593](https://github.com/GlueOps/platform-helm-chart-platform/issues/1593)) ([dd1c95c](https://github.com/GlueOps/platform-helm-chart-platform/commit/dd1c95cc66f2cc451cc697839bc1e46a7eed2f7d))
* update helm release reflector to v10.0.71 ([#1596](https://github.com/GlueOps/platform-helm-chart-platform/issues/1596)) ([4c0a2ba](https://github.com/GlueOps/platform-helm-chart-platform/commit/4c0a2bac1fc54fd89edbfd6ecab67d550cab892f))
* update k8s.repo.gpkg.io/autoscaling/vpa-admission-controller docker tag to v1.7.3 ([#1548](https://github.com/GlueOps/platform-helm-chart-platform/issues/1548)) ([ad3ccb8](https://github.com/GlueOps/platform-helm-chart-platform/commit/ad3ccb85d327d2db0c334f8db53d506b35a79f5e))
* update k8s.repo.gpkg.io/autoscaling/vpa-recommender docker tag to v1.7.3 ([#1549](https://github.com/GlueOps/platform-helm-chart-platform/issues/1549)) ([fbbc08c](https://github.com/GlueOps/platform-helm-chart-platform/commit/fbbc08cddb6b4369d923456b66bdfe37a0f80517))
* update k8s.repo.gpkg.io/autoscaling/vpa-updater docker tag to v1.7.3 ([#1550](https://github.com/GlueOps/platform-helm-chart-platform/issues/1550)) ([9fed62e](https://github.com/GlueOps/platform-helm-chart-platform/commit/9fed62e7b5d75f643783cd7d3119eefa2270081f))
* update quay.io/jetstack/charts/cert-manager docker tag to v1.21.3 ([#1585](https://github.com/GlueOps/platform-helm-chart-platform/issues/1585)) ([c78c8dc](https://github.com/GlueOps/platform-helm-chart-platform/commit/c78c8dcc0a639158f248a5c09876bfa696d1133d))
* update quay.repo.gpkg.io/jetstack/cert-manager-acmesolver docker tag to v1.21.3 ([#1580](https://github.com/GlueOps/platform-helm-chart-platform/issues/1580)) ([ad6eb58](https://github.com/GlueOps/platform-helm-chart-platform/commit/ad6eb589855280c6ae8db9de13fae58154b794cf))
* update quay.repo.gpkg.io/jetstack/cert-manager-cainjector docker tag to v1.21.3 ([#1581](https://github.com/GlueOps/platform-helm-chart-platform/issues/1581)) ([9e08a94](https://github.com/GlueOps/platform-helm-chart-platform/commit/9e08a948fd67d92ffd0f2771ab64dcc001ebadf0))
* update quay.repo.gpkg.io/jetstack/cert-manager-controller docker tag to v1.21.3 ([#1582](https://github.com/GlueOps/platform-helm-chart-platform/issues/1582)) ([c83c8e0](https://github.com/GlueOps/platform-helm-chart-platform/commit/c83c8e0bf24334ae87bb42dceebcf86631ad15ab))
* update quay.repo.gpkg.io/jetstack/cert-manager-startupapicheck docker tag to v1.21.3 ([#1583](https://github.com/GlueOps/platform-helm-chart-platform/issues/1583)) ([c648ddb](https://github.com/GlueOps/platform-helm-chart-platform/commit/c648ddb97711acb6329b3bab01edcb382e93d411))
* update quay.repo.gpkg.io/jetstack/cert-manager-webhook docker tag to v1.21.3 ([#1584](https://github.com/GlueOps/platform-helm-chart-platform/issues/1584)) ([9928f59](https://github.com/GlueOps/platform-helm-chart-platform/commit/9928f59eaadcbc73d39014288ffba83ac928b154))
* update quay.repo.gpkg.io/oauth2-proxy/oauth2-proxy docker tag to v7.15.5 ([#1552](https://github.com/GlueOps/platform-helm-chart-platform/issues/1552)) ([32b0e86](https://github.com/GlueOps/platform-helm-chart-platform/commit/32b0e86248175402fadb4aa1758a579e294eaba9))

## [0.82.0](https://github.com/GlueOps/platform-helm-chart-platform/compare/v0.81.0...v0.82.0) (2026-10-27)


### Features

* inventory-agent v1.2.0, receiver at inventory-agent.observability.glueopshosted.com ([#1589](https://github.com/GlueOps/platform-helm-chart-platform/issues/1589)) ([baaf0d9](https://github.com/GlueOps/platform-helm-chart-platform/commit/baaf0d98233d042d622ec693fc1e21bfd50a8bde))
* update ghcr.repo.gpkg.io/dexidp/dex to v2.46.1 #minor ([#1533](https://github.com/GlueOps/platform-helm-chart-platform/issues/1533)) ([004e5ce](https://github.com/GlueOps/platform-helm-chart-platform/commit/004e5cea953cc424ea40a164293d1aff891eb697))
* update ghcr.repo.gpkg.io/glueops/inventory-agent to v1.1.0 #minor ([#1523](https://github.com/GlueOps/platform-helm-chart-platform/issues/1523)) ([7be1f28](https://github.com/GlueOps/platform-helm-chart-platform/commit/7be1f2868c6b9f51a174f248f6f1e46a7f083698))


### Bug Fixes

* **renovate:** track templated OpenBao/external-secrets charts; latest patch per minor ([#1544](https://github.com/GlueOps/platform-helm-chart-platform/issues/1544)) ([4835abb](https://github.com/GlueOps/platform-helm-chart-platform/commit/4835abb32dd9676d21bd82b2782bb7f481d2b581))
* spread traefik replicas across nodes and rebalance with descheduler ([#1526](https://github.com/GlueOps/platform-helm-chart-platform/issues/1526)) ([e40f23b](https://github.com/GlueOps/platform-helm-chart-platform/commit/e40f23bddf8e2e6ac2a71476350df1290932a266))
* zero-downtime rollouts and drains for qr-code-generator ([#1525](https://github.com/GlueOps/platform-helm-chart-platform/issues/1525)) ([e56b8bd](https://github.com/GlueOps/platform-helm-chart-platform/commit/e56b8bd8f8b09215422fd7d031e4b4f48303514f))


### Miscellaneous Chores

* **patch:** update quay.repo.gpkg.io/openbao/openbao to 2.6.4 #patch ([#1553](https://github.com/GlueOps/platform-helm-chart-platform/issues/1553)) ([733643e](https://github.com/GlueOps/platform-helm-chart-platform/commit/733643e1654671da496b4ae01eb4beb8c3a42bc9))
* **patch:** update quay.repo.gpkg.io/openbao/openbao to 2.6.5 #patch ([#1588](https://github.com/GlueOps/platform-helm-chart-platform/issues/1588)) ([309ef5f](https://github.com/GlueOps/platform-helm-chart-platform/commit/309ef5f21314342d3b41c971fec164aa1c4b4891))

## [0.81.0](https://github.com/GlueOps/platform-helm-chart-platform/compare/v0.80.2...v0.81.0) (2026-10-21)


### Features

* add glueops-core-inventory-agent ([#1516](https://github.com/GlueOps/platform-helm-chart-platform/issues/1516)) ([de288e1](https://github.com/GlueOps/platform-helm-chart-platform/commit/de288e11457270270a1fa8db761b6118147dc94c))
* update ghcr.repo.gpkg.io/glueops/cluster-information-help-page-html to v4.31.0 #minor ([#1520](https://github.com/GlueOps/platform-helm-chart-platform/issues/1520)) ([8ab06a3](https://github.com/GlueOps/platform-helm-chart-platform/commit/8ab06a36cd091bf7323a668a7d4a9b0e68435aa7))


### Bug Fixes

* disable goldilocks cost integration email prompt ([#1518](https://github.com/GlueOps/platform-helm-chart-platform/issues/1518)) ([1fa1e8b](https://github.com/GlueOps/platform-helm-chart-platform/commit/1fa1e8bed14b7510957cbc843018f6236328160d))

## [0.80.2](https://github.com/GlueOps/platform-helm-chart-platform/compare/v0.80.1...v0.80.2) (2026-09-29)


### Bug Fixes

* monitor etcd on port 2381 without creds ([#1514](https://github.com/GlueOps/platform-helm-chart-platform/issues/1514)) ([30668b1](https://github.com/GlueOps/platform-helm-chart-platform/commit/30668b188a0f6688dc9779fbec0b25435bb2d925))

## [0.80.1](https://github.com/GlueOps/platform-helm-chart-platform/compare/v0.80.0...v0.80.1) (2026-09-22)


### Bug Fixes

* revert back etcd metrics in prometheus ([#1512](https://github.com/GlueOps/platform-helm-chart-platform/issues/1512)) ([b46786b](https://github.com/GlueOps/platform-helm-chart-platform/commit/b46786b8de13b7d430a49dd2f07da435ef6590de))

## [0.80.0](https://github.com/GlueOps/platform-helm-chart-platform/compare/v0.79.2...v0.80.0) (2026-09-18)


### ⚠ BREAKING CHANGES

* requires platform-crds with matching CRDs (cert-manager v1.21.2, external-secrets v2.10.0, metacontroller v4.17.2, traefik chart 41.5.0, keda v2.20.2) to be applied before this release syncs.

### Features

* upgrade platform components for Kubernetes 1.35 ([#1498](https://github.com/GlueOps/platform-helm-chart-platform/issues/1498)) ([c6a2f04](https://github.com/GlueOps/platform-helm-chart-platform/commit/c6a2f04434d775e1b313f5c5a371d3abd076d16c))

## [0.79.2](https://github.com/GlueOps/platform-helm-chart-platform/compare/v0.79.1...v0.79.2) (2026-09-06)


### Miscellaneous Chores

* bump certs-backup-restore to v2.4.0 ([#1493](https://github.com/GlueOps/platform-helm-chart-platform/issues/1493)) ([e6cbcbc](https://github.com/GlueOps/platform-helm-chart-platform/commit/e6cbcbced3e268f7ea45808ea9ec4d2774cbbd3e))

## [0.79.1](https://github.com/GlueOps/platform-helm-chart-platform/compare/v0.79.0...v0.79.1) (2026-09-06)


### Bug Fixes

* make cert restore work at bootstrap (RBAC ordering, namespace creation, backup scope) ([#1491](https://github.com/GlueOps/platform-helm-chart-platform/issues/1491)) ([ec66a6b](https://github.com/GlueOps/platform-helm-chart-platform/commit/ec66a6b84ec416b5b5bad1492b0b8e6ba39a19ce))

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
