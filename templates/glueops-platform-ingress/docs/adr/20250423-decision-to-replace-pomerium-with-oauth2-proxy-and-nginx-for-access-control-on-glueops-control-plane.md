# Decision to replace Pomerium with OAuth2 Proxy and Nginx for Access Control on GlueOps Control Plane Components

- Status: draft
- Deciders: Hamza Bouissa, Venkata Mutyala
- Date: 2025-04-22
- Tags: ingress, oauth2

Technical Story: I need to be able to secure the glueops platform control plane components so that team members and customers can easily access them without having to deal with many layers of authentication such as a VPN. I also don't want to expose them publicly in case there is a future vulnerability in one or more of the components.

## Context and Problem Statement

We need to secure access to critical internal control plane components (ArgoCD, Grafana, Vault, cluster-info) that are currently not exposed publicly but require authenticated access for team members. Traditional access methods like VPNs are cumbersome and provide overly broad network access. We need a solution that provides robust security (including defense-in-depth and avoiding public exposure) while ensuring ease of use for authorized internal users. How can we implement a secure, user-friendly access control layer for these internal tools that balances security requirements with usability and integrates well with our existing infrastructure?

## Decision Drivers

- Enhanced Security for Critical Components
- Improved Ease of Access for Team Members
- Avoid Public Exposure
- Balance Security and Usability (Key Driver)
- Defense-in-Depth
- Minimize Client-Side Hassle

## Considered Options

- Pomerium
- OAuth2Proxy w/ ingress-nginx via external-auth
- Authentik
- Cloudflare Tunnels
- Terraform Boundary

## Decision Outcome

Chosen option: "OAuth2Proxy w/ ingress-nginx via external-auth", because it effectively balances security and usability by integrating with our familiar nginx ingress, aligning with existing internal practices, and addressing the specific issues encountered with the previous solution, Pomerium, despite some initial configuration challenges and deployment considerations.

### Positive Consequences

- All traffic access logs are available via nginx, providing a consistent logging format.
- Less complexity and fewer solution-specific annotations to deal with compared to Pomerium.
- We can leverage our existing expertise and configurations with nginx.
- It was possible to implement as a near "drop-in replacement" functionally.
- Successfully working for our internal Tools API demonstrates its capability.
- Enabled a potential cost saving by moving to a cheaper AWS NLB.

### Negative Consequences

- The initial configurations were a little hard to understand and required a bit of trial and error to get correct.
- Deployment necessitates replacing the Load Balancer, resulting in approximately 15 minutes of control plane downtime due to potential DNS propagation delays (NXDOMAIN).
- Required deploying an additional ingress nginx deployment to maintain separation between public and internal load balancers.

## Pros and Cons of the Options

### Pomerium

- Good, because it seemed to work well for our immediate needs previously.
- Good, because their team is pretty responsive to github issues.
- Bad, because annotations were different than what we were using for nginx, creating a learning curve.
- Bad, because there is no white listing of IPs unless we go enterprise.
- Bad, because we hit a few bugs specific to our use cases (e.g., ingress controller NodePort, EKS mixed protocol issue).
- Bad, because of random access denied/refreshes were experienced (likely a misconfiguration, but a practical problem).
- Bad, because the log format was different than what we had for nginx.
- Bad, because it was beginning to feel like we might be an outlier in how their software is being used.

### OAuth2Proxy w/ ingress-nginx via external-auth

- Good, because it has been working well for our Tools API already.
- Good, because traffic logs are all in nginx format.
- Good, because it works with nginx so we can easily leverage other nginx annotations.
- Good, because it just works for exactly how we used pomerium.
- Bad, because annotations we used took a little while to figure out and get right as the nginx docs didn't seem to be entirely spot on.
- Bad, because it requires an nginx installation to use it work (though we deployed an additional one for architectural separation).

### Authentik

- Good, because it looked like pomerium and a potential functional alternative.
- Bad, because of its for-profit business model.
- Bad, because of concerns around a Opensource "rug pull" down the road given the VC backing.

### Cloudflare Tunnels

- Good, because CloudFlare is generally a good product offering.
- Bad, because cost was a concern.
- Bad, because using a client felt like friction/headaches for our users.

### Terraform Boundary

- Bad, because it didn't support SSL at the time we looked into it.
- Bad, because future license changes have turned us off from using Hashicorp products.
- Bad, because it requires a client application.

## Links

- [Example Implementation Helm Chart](https://github.com/GlueOps/platform-helm-chart-platform/blob/fix_ingress/templates/application-nginx-glueops-platform-oauth2.yaml)
- [OAuth2 Proxy Documentation](https://oauth2-proxy.github.io/oauth2-proxy/configuration/overview) (v7.7.8 at the time of writing)
- [Pomerium Ingress Controller Issue: NodePort bug](https://github.com/pomerium/ingress-controller/pull/1099)
- [Pomerium Ingress Controller Issue: EKS mixed protocol](https://github.com/pomerium/ingress-controller/issues/1142)