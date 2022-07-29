DOCKER_IMAGE := growing-relic
IP           := 127.0.0.1

FE_DOMAIN    := fe.growing-relic.home.arpa
FE_PORT      := 9990

API_DOMAIN   := api.growing-relic.home.arpa
API_PORT     := 9980

PORTS        := $(FE_PORT) $(API_PORT)
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
	curl -v http://$(IP):$(FE_PORT)/posts -H "Host: $(FE_DOMAIN):$(FE_PORT)"
	@echo
	@echo "==================="
	@echo " [FE] POST /posts"
	@echo "==================="
	curl -v http://$(IP):$(FE_PORT)/posts -H "Host: $(FE_DOMAIN):$(FE_PORT)" -X POST --data-raw '{}' -H "Content-Type: application/json"
