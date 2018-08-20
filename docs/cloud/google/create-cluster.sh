#!/bin/bash

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.


# THIS SCRIPT IS NOT MEANT TO BE EXECUTED AS IS.
# IT IS ONLY CURRENTLY MEANT AS DOCUMENTATION ACTUALLY.


# see gcp for downloading the sdk.. configuring 
# gcloud and kubectl.


# create cluster remove glbc and enable autoscalers
gcloud container clusters create cluster01 \
    --addons=HorizontalPodAutoscaling      \
    --addons=KubernetesDashboard           \
    --num-nodes 3                          \
    --enable-autoscaling                   \
    --min-nodes 0                          \
    --max-nodes 10



# NOTE: install helm at this time

######## istio installation #######

# see istio docs for download and binary

# install istio CRDs
kubectl apply -f install/kubernetes/helm/istio/templates/crds.yaml -n istio-system

# install certmanager CRDs
kubectl apply -f install/kubernetes/helm/istio/charts/certmanager/templates/crds.yaml

# install w/ helm and tiller
    # create service account
kubectl create -f install/kubernetes/helm/helm-service-account.yaml

# install tiller w/ service account
helm init --service-account tiller

# install istio and set NodePort instead of LoadBalancer
helm install install/kubernetes/helm/istio --name istio --namespace istio-system

# install pilot and citadel
helm install install/kubernetes/helm/istio --name istio --namespace istio-system \
  --set ingress.enabled=false \
  --set gateways.istio-ingressgateway.enabled=false \
  --set gateways.istio-egressgateway.enabled=false \
  --set galley.enabled=false \
  --set sidecarInjectorWebhook.enabled=false \
  --set mixer.enabled=false \
  --set prometheus.enabled=false \
  --set global.proxy.envoyStatsd.enabled=false


# manual sidecar injection
istioctl kube-inject -f samples/sleep/sleep.yaml | kubectl apply -f -

# verify injection
kubectl get deployment sleep -o wide

# grant admin perms to current user
kubectl create clusterrolebinding cluster-admin-binding \
    --clusterrole=cluster-admin \
    --user=$(gcloud config get-value core/account)



####### haproxy load balancer #######

# add the repo to helm
helm repo add appscode https://charts.appscode.com/stable/


# update
helm repo update

# check
helm search appscode/voyager

# install
helm install appscode/voyager --name voyager-operator --version 7.4.0 \
  --namespace kube-system \
  --set cloudProvider=$provider \
  --set apiserver.ca="$(onessl get kube-ca)" \
  --set apiserver.enableValidatingWebhook=true \
  --set apiserver.enableStatusSubresource=true

# install onessl
curl -fsSL -o onessl https://github.com/kubepack/onessl/releases/download/0.3.0/onessl-linux-amd64 \
  && chmod +x onessl \
  && sudo mv onessl /usr/local/bin/

# verify install
kubectl get pods --all-namespaces -l app=voyager --watch

# confirm CRD groups
kubectl get crd -l app=voyager



# Namecheap

#     Provider: namecheap
#     Credential secret keys:
#         NAMECHEAP_API_USER: The username of a Namecheap user
#         NAMECHEAP_API_KEY: The API key corresponding with the Namecheap user


