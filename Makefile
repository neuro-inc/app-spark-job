IMAGE_REPO ?= ghcr.io/neuro-inc
IMAGE_IMAGE ?= pyspark-dep-manager
IMAGE_IMAGE_TAG ?= latest
IMAGE_REPO_IMAGE_REF = $(IMAGE_REPO)/$(IMAGE_IMAGE):$(IMAGE_IMAGE_TAG)

SHELL := /bin/sh -e

.PHONY: build-image
build-image-pydeps:
	@echo "Building Docker image"
	docker build \
		-t $(IMAGE_IMAGE):latest ./pyspark-dep-manager


.PHONY: push-image
push-image-pydeps:
	docker tag $(IMAGE_IMAGE):latest $(IMAGE_REPO_IMAGE_REF)
	docker push $(IMAGE_REF)
