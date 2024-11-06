#! /bin/bash

# Minikube delete
CLUSTER_NAME=demo-gitops

minikube delete -p $CLUSTER_NAME
