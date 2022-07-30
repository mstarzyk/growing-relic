.PHONY: metadata
metadata:
	nix-flakes flake metadata

.PHONY: lock
lock:
	nix-flakes flake lock

.PHONY: build
build:
	nix-flakes build --no-update-lock-file
