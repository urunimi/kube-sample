#!/bin/sh
set -e

if [ -z "$TAG" ]; then
	TAG=`git rev-parse --short HEAD`
fi

IMAGE_NAME=urunimi/hello-go

if [ -z "$WORKSPACE" ]; then
	WORKSPACE=`pwd`
fi

cd $WORKSPACE/hello-go

echo "IMAGE_NAME: $IMAGE_NAME, TAG: $TAG"

echo "--------- Clean up docker images -----------"

docker images prune

IMAGE_COUNT=`docker images | grep $IMAGE_NAME | wc -l`
[ $IMAGE_COUNT -gt 5 ] && docker rmi -f `docker images | grep $IMAGE_NAME | tail -$(( $IMAGE_COUNT - 5 )) | awk '{split($1,a,"\t"); print $3}'`

echo "--------- Build and push a docker image -----------"

if [[ "$TAG" == "latest" ]] || [[ "$(docker images -q ${IMAGE_NAME}:${TAG} 2> /dev/null)" == "" ]]; then
	# go test $(go list ./... | grep -v /vendor/)
	sed -i.bak "s/Hello world/$TAG/g" main.go
	docker build -t ${IMAGE_NAME}:${TAG} .
	git checkout main.go
	rm main.go.bak
	docker push ${IMAGE_NAME}:${TAG}
else
	echo "Skipping docker build because it already exists"
fi

if [ "master" = "$BRANCH_NAME" ]; then
	docker tag $IMAGE_NAME:$TAG $IMAGE_NAME:latest
	docker push $IMAGE_NAME:latest
fi
