IMAGE_REPO ?= ghcr.io/neuro-inc
IMAGE_NAME ?= pyspark-dep-manager
IMAGE_TAG ?= latest
IMAGE_REF = $(IMAGE_REPO)/$(IMAGE_NAME):$(IMAGE_TAG)

SHELL := /bin/sh -e

.PHONY: build-image
build-image-pydeps:
	@echo "Building Docker image"
	docker build \
		-t $(IMAGE_NAME):latest ./pyspark-dep-manager


.PHONY: push-image
push-image-pydeps:
	docker tag $(IMAGE_NAME):latest $(IMAGE_REF)
	docker push $(IMAGE_REF)
