VERSION=1.33.4
NAME=ghcr.io/uenob/kubectl:$(VERSION)
SHA256=c2ba72c115d524b72aaee9aab8df8b876e1596889d2f3f27d68405262ce86ca1
DOCKER=docker

kubectl.tar: Dockerfile kubectl-$(VERSION)
	$(DOCKER) buildx build --build-arg VERSION=$(VERSION) --platform linux/amd64 -t $(NAME) .
	$(DCOKER) save -o $@ $(NAME)

kubectl-$(VERSION):
	curl -L -o $@ https://dl.k8s.io/release/v$(VERSION)/bin/linux/amd64/kubectl
	test "$$(sha256sum $@)" = '$(SHA256)  $@'
