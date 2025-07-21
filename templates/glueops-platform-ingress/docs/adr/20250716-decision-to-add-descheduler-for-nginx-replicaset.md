# decision to add descheduler for nginx replicaset

- Status: [draft]
- Deciders: Hamza Bouissa, Venkata Mutyala
- Date: 2025-07-16
- Tags: nginx,kube-scheduler,descheduler,replicaset

Technical Story: The current scheduling behavior of Nginx replicasets does not ensure even distribution across nodes, leading to potential availability issues in case of node failures.

## Context and Problem Statement

During a recent incident, a node failure in the customer production node pool resulted in two Nginx replicas running on a single node. By default, Nginx replicas should be spread across as many nodes as possible to ensure high availability. However, when capacity is limited, the scheduler should distribute pods across available nodes and re-balance them when new nodes are added.

## Decision Drivers 

- High Availability of Nginx: Ensure that Nginx pods are distributed across multiple nodes to minimize the impact of node failures.
- Automation: Automate the process of re-scheduling pods when node state changes.


## Considered Options

- Descheduler: Utilize the Kubernetes Descheduler to re-balance pods across nodes

## Decision Outcome

We will implement the Descheduler for Nginx ReplicaSets to ensure even distribution of pods across nodes.


### Positive Consequences

- Eliminate the need for manual pod re-scheduling after node state changes.
- Improve high availability of Nginx by ensuring pods are distributed across multiple nodes. 

### Negative Consequences

- Additional component to monitor and manage.


## Links

- Core feature we're using: https://github.com/kubernetes-sigs/descheduler?tab=readme-ov-file#removeduplicates

