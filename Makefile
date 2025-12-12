IMAGE_REPO ?= ghcr.io/neuro-inc
IMAGE_NAME ?= pyspark-dep-manager
IMAGE_TAG ?= latest
IMAGE_REF = $(IMAGE_REPO)/$(IMAGE_NAME):$(IMAGE_TAG)
HOOK_IMAGE_NAME ?= mlops-app-spark-job
HOOK_IMAGE_TAG := latest


SHELL := /bin/sh -e


.PHONY: all clean test lint format
all clean test lint format:


.PHONY: test
test:

.PHONY: clean
clean:


.PHONY: build-image
build-image-pydeps:
	@echo "Building Docker image"
	docker build \
		-t $(IMAGE_NAME):latest ./pyspark-dep-manager


.PHONY: push-image
push-image-pydeps:
	docker tag $(IMAGE_NAME):latest $(IMAGE_REF)
	docker push $(IMAGE_REF)

.PHONY: install setup
install setup: poetry.lock
	poetry config virtualenvs.in-project true
	poetry install --with dev
	poetry run pre-commit install;

.PHONY: format
format:
ifdef CI
	poetry run pre-commit run --all-files --show-diff-on-failure
else
	# automatically fix the formatting issues and rerun again
	poetry run pre-commit run --all-files || poetry run pre-commit run --all-files
endif


.PHONY: lint
lint: format
	poetry run mypy .apolo

.PHONY: test-unit
test-unit:
	poetry run pytest -vvs --cov=.apolo --cov-report xml:.coverage.unit.xml .apolo/tests/unit


.PHONY: build-hook-image
build-hook-image:
	docker build \
		--build-arg APP_IMAGE_TAG=$(HOOK_IMAGE_TAG) \
		-t $(HOOK_IMAGE_NAME):latest \
		-f hooks.Dockerfile \
		.;

.PHONY: push-hook-image
push-hook-image:
	docker tag $(HOOK_IMAGE_NAME):latest ghcr.io/neuro-inc/$(HOOK_IMAGE_NAME):$(HOOK_IMAGE_TAG)
	docker push ghcr.io/neuro-inc/$(HOOK_IMAGE_NAME):$(HOOK_IMAGE_TAG)

.PHONY: gen-types-schemas
gen-types-schemas:
	app-types dump-types-schema .apolo/src/apolo_apps_spark_job SparkJobInputs .apolo/src/apolo_apps_spark_job/schemas/SparkJobInputs.json
	app-types dump-types-schema .apolo/src/apolo_apps_spark_job SparkJobOutputs .apolo/src/apolo_apps_spark_job/schemas/SparkJobOutputs.json
