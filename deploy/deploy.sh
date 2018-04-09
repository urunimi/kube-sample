#!/bin/sh
set -e

git checkout deploy/kube/

export GIT_REVISION=`git rev-parse --short HEAD`
export TAG="$GIT_REVISION"
bash ./deploy/build-docker.sh
sed -i.bak "s/latest/${GIT_REVISION}/" deploy/kube/app-hello-go.yaml
kubectl config use-context k8s-test.honeyscreen.com
kubectl replace -f deploy/kube/app-hello-go.yaml
rm deploy/kube/app-hello-go.yaml.bak
git checkout deploy/kube/
kubectl rollout status deploy hello-go