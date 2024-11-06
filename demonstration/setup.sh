#! /bin/bash

# Minikube setup
KUBERNETES_VERSION=v1.31.0
CLUSTER_NAME=demo-gitops

minikube start --kubernetes-version=$KUBERNETES_VERSION -p $CLUSTER_NAME
minikube addons enable ingress -p $CLUSTER_NAME
# minikube addons enable ingress-dns -p $CLUSTER_NAME

# ArgoCD setup
ARGOCD_HELM_REPO=https://argoproj.github.io/argo-helm
ARGOCD_HELM_CHART_NAME=argo-cd
ARGOCD_CHART_VERSION=7.7.0
ARGOCD_VALUES_PATH=argocd/helm/values.yaml

# Prepare helm repo
helm repo add argo $ARGOCD_HELM_REPO
helm repo update

# Install ArgoCD
helm upgrade --install argocd argo/$ARGOCD_HELM_CHART_NAME --version $ARGOCD_CHART_VERSION --namespace argocd --create-namespace --values $ARGOCD_VALUES_PATH
sleep 10
echo ArgoCD admin password: $(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)

echo "Create a port forward for ArgoCD"
echo "kubectl -n argocd port-forward svc/argocd-server 8080:80"

# Setup GitOps
kubectl -n argocd apply -f argocd/secrets
kubectl -n argocd apply -f argocd/projects
kubectl -n argocd apply -f argocd/applications
