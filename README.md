# renovate-meetup

Renovate presentation with GitOps.

## Repository architecture

* [Démonstration](https://github.com/maximeancellin/renovate-meetup/tree/main/demonstration)
* [Présentation](https://github.com/maximeancellin/renovate-meetup/tree/main/renovate-gitops)

## Requirements

To start the presentation, you need the following tools installed or configured:

| Name | Version | Description |
|---|---|---|
| Docker| `26.1.4` | Docker container runtime |
| Kubectl | `v1.32.0` | Kubernetes command-line tool |
| Minikube | `1.34.0` | Local Kubernetes instance |
| kubernetes | `v1.32.0` | Kubernetes container orchestrator *(wrapped inside minikube)* |
| Helm | `3.16.3` | Kubernetes package manager |
| ArgoCD | `2.13.0` | GitOps controller *(wrapped inside setup script)* |
| Renovate | `SaaS` | Package manager |

## Quick start

To run demonstration, you must follow the below instructions.

### Configure project

**Prepare project**
```bash
# Create secrets folder (from root of project)
mkdir demonstration/argocd/secrets

# Add remote project access token for ArgoCD
touch demonstration/argocd/secrets/github-demo-app-secrets.yaml
```

**Configure a Git secret**
```yaml
apiVersion: v1
kind: Secret
metadata:
  annotations:
    managed-by: argocd.argoproj.io
  labels:
    argocd.argoproj.io/secret-type: repository
  name: github-demo-app
  namespace: argocd
type: Opaque
data:
  name: your-repo # Repository name in base64
  sshPrivateKey: Add yours # in base64
  type: Z2l0 # Git in base64
  url: ssh url # in base64
```

**Configure your GitOps project and applications**

Inside files in the `demonstration/gitops` folder, adapt to match with your needs.

### Run project
```bash
# Get the project
git clone https://github.com/renovate-meetup/demonstration.git

# Move inside demonstration folder
cd demonstration

# Start the project
./setup.sh
```

### Stop or cleanup project

**Stop project**
```bash
# Stop the project
minikube stop
```

**Remove project**
```bash
# Stop the project
./clean-up.sh
```

## Blog posts

You can found the blog posts about the subject on [SoKube Blog](https://www.sokube.io/blog).

- [Dependencies Management Tools](https://www.sokube.io/en/blog/dependencies_management_tools-en)
- [GitOps with Renovate](https://www.sokube.io/en/blog/055_dependencies_management_tools-en)
