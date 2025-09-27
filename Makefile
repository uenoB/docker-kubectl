VERSION=1.33.2
NAME=ghcr.io/uenob/kubectl:$(VERSION)
SHA256=33d0cdec6967817468f0a4a90f537dfef394dcf815d91966ca651cc118393eea
DOCKER=docker

kubectl.tar: Dockerfile kubectl-$(VERSION)
	$(DOCKER) buildx build --build-arg VERSION=$(VERSION) --platform linux/amd64 -t $(NAME) .
	$(DCOKER) save -o $@ $(NAME)

kubectl-$(VERSION):
	curl -L -o $@ https://dl.k8s.io/release/v$(VERSION)/bin/linux/amd64/kubectl
	test "$$(sha256sum $@)" = '$(SHA256)  $@'
