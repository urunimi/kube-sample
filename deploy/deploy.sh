#!/bin/sh
set -e

git checkout kube/

export GIT_REVISION=`git rev-parse --short HEAD`
export TAG="$GIT_REVISION"
bash ./deploy/build-docker.sh
sed -i.bak "s/latest/${GIT_REVISION}/" kube/app-hello-go.yaml
kubectl config use-context k8s-test.honeyscreen.com
kubectl replace -f kube/app-hello-go.yaml
rm kube/app-hello-go.yaml.bak
git checkout kube/
kubectl rollout status deploy hello-go