VERSION=1.36.4
NAME=ghcr.io/uenob/kubectl:$(VERSION)
SHA256=8b8f088da2dab964f853b38464033b1be15ede2839eca751482357c45abdd05a
DOCKER=docker

kubectl.tar: Dockerfile kubectl-$(VERSION)
	$(DOCKER) buildx build --build-arg VERSION=$(VERSION) --platform linux/amd64 -t $(NAME) .
	$(DOCKER) save -o $@ $(NAME)

kubectl-$(VERSION):
	curl -L -o $@ https://dl.k8s.io/release/v$(VERSION)/bin/linux/amd64/kubectl
	test "$$(sha256sum $@)" = '$(SHA256)  $@'
