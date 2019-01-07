#!/bin/bash

HELM_HOME=${HOME}/.helm
HELM_CERT_DIR="${HELM_HOME}/certificates"
WORKDIR=${HOME}/dev/src/github.com/codedepottech/infrastructure/
ISTIO_HOME=${HOME}/dev/src/github.com/prodatalab/istio/
ttf="--tls-hostname=tiller-server"

# if [ ! -d $HELM_CERT_DIR ]; then mkdir -p ${HELM_CERT_DIR}; fi

# pushd $WORKDIR

# gcloud container clusters create \
# --cluster-version="1.11.5-gke.5" \
# --enable-autoupgrade \
# --machine-type=n1-standard-2 \
# --preemptible \
# --enable-autoscaling \
# --max-nodes=5 \
# --min-nodes=0 \
# cluster01

# gcloud container clusters get-credentials cluster01

# assumes helm is already installed on local compute

# check for certs and create if needed
# if [ ! -f ~/.helm/certificates/ca.cert.pem ] ||
#     [ ! -f ~/.helm/certificates/ca.key.pem ] || 
#     [ ! -f ~/.helm/certificates/helm.key.pem ] ||
#     [ ! -f ~/.helm/certificates/tiller.key.pem ]; then
#     echo 'File(s) not found! ..creating certificates'
#     pushd ${HELM_CERT_DIR}
#     openssl genrsa -out ./ca.key.pem 4096
#     openssl req -key ca.key.pem -new -x509 -days 7300 -sha256 -out ca.cert.pem \
#         -subj "/C=US/ST=CO/L=Boulder/O=tiller/CN=tiller"
#     openssl genrsa -out ./tiller.key.pem 4096
#     openssl genrsa -out ./helm.key.pem 4096
#     openssl req -key tiller.key.pem -new -sha256 -out tiller.csr.pem \
#         -subj "/C=US/ST=CO/L=Boulder/O=Tiller Server/CN=tiller-server"
#     openssl req -key helm.key.pem -new -sha256 -out helm.csr.pem \
#         -subj "/C=US/ST=CO/L=Boulder/O=Helm Client/CN=helm-client"


#     openssl x509 -req -CA ca.cert.pem -CAkey ca.key.pem -CAcreateserial -in tiller.csr.pem -out tiller.cert.pem -days 365
#     openssl x509 -req -CA ca.cert.pem -CAkey ca.key.pem -CAcreateserial -in helm.csr.pem -out helm.cert.pem  -days 365
#     popd
#     pushd $HELM_HOME
#     ln -s certificates/ca.cert.pem ca.pem 
#     ln -s certificates/helm.cert.pem cert.pem 
#     ln -s certificates/helm.key.pem key.pem 
#     popd 
# else 
#     echo "certificates found..."
# fi

# if [ -f ~/.helm/certificates/ca.cert.pem ] &&
#     [ -f ~/.helm/certificates/ca.key.pem ] && 
#     [ -f ~/.helm/certificates/helm.key.pem ] &&
#     [ -f ~/.helm/certificates/tiller.key.pem ]; then
#     echo 'certificates created in ${HELM_CERT_DIR}'
# else 
#     echo 'certificates already exist.. continuing'
# fi

# kubectl create -f rbac-config.yaml

pushd $HELM_CERT_DIR


helm init \
--tiller-tls \
--tiller-tls-cert="${HELM_CERT_DIR}/tiller.cert.pem" \
--tiller-tls-key="${HELM_CERT_DIR}/tiller.key.pem" \
--tiller-tls-verify \
--tls-ca-cert="${HELM_CERT_DIR}/ca.cert.pem" \
--service-account="tiller"

popd

# pushd $ISTIO_HOME

# helm install install/kubernetes/helm/istio $ttf --name istio --namespace istio-system

# popd 

### see all resources in a namespace
# kubectl api-resources --verbs=list --namespaced -o name \
###

# popd