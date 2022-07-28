DOCKER_IMAGE := growing-relic

.PHONY: all
all: run

.PHONY: build-docker
build-docker:
	docker build -t $(DOCKER_IMAGE) --network=host .

.PHONY: run
run:
	docker run --rm -it $(DOCKER_IMAGE) bash
	# docker run --rm -it --network=host $(DOCKER_IMAGE) bash
