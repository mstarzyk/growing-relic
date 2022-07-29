DOCKER_IMAGE := growing-relic
IP := 127.0.0.1
PORTS := -p $(IP):9980:9980 -p $(IP):9990:9990

.PHONY: all
all: run

.PHONY: build-docker
build-docker:
	docker build -t $(DOCKER_IMAGE) --network=host .

.PHONY: run
run:
	docker run --rm -it $(PORTS) --entrypoint bash $(DOCKER_IMAGE)

.PHONY: server
server:
	docker run --rm $(PORTS) $(DOCKER_IMAGE)

.PHONY: test
test:
	@echo "==================="
	@echo " [FE] GET /posts"
	@echo "==================="
	curl -v http://$(IP):9980/posts
	@echo
	@echo "==================="
	@echo " [FE] POST /posts"
	@echo "==================="
	curl -v http://$(IP):9980/posts -X POST --data-raw '{}'
