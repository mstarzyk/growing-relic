DOCKER_IMAGE := growing-relic
IP           := 127.0.0.1
PORT_FE      := 9980
PORT_API     := 9990
PORTS        := $(PORT_FE) $(PORT_API)

PORTS_ARG    := $(foreach p,$(PORTS),-p $(IP):$(p):$(p))


.PHONY: all
all: run


.PHONY: build-docker
build-docker:
	docker build -t $(DOCKER_IMAGE) --network=host .


.PHONY: run
run:
	docker run --rm -it --entrypoint bash $(PORTS_ARG) $(DOCKER_IMAGE)


.PHONY: server
server:
	docker run --rm $(PORTS_ARG) $(DOCKER_IMAGE)


.PHONY: curl
curl:
	@echo "==================="
	@echo " [FE] GET /posts"
	@echo "==================="
	curl -v http://$(IP):$(PORT_FE)/posts
	@echo
	@echo "==================="
	@echo " [FE] POST /posts"
	@echo "==================="
	curl -v http://$(IP):$(PORT_FE)/posts -X POST --data-raw '{}'
