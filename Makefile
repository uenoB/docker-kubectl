VERSION=1.28.7
NAME=ghcr.io/uenob/kubectl:$(VERSION)
SHA256=aff42d3167685e4d8e86fda0ad9c6ce6ec6c047bc24d608041d54717a18192ba

kubectl.tar: Dockerfile kubectl-$(VERSION)
	docker buildx build --build-arg VERSION=$(VERSION) --platform linux/amd64 -t $(NAME) .
	docker save -o $@ $(NAME)

kubectl-$(VERSION):
	curl -L -o $@ https://dl.k8s.io/release/v$(VERSION)/bin/linux/amd64/kubectl
	test "$$(sha256sum $@)" = '$(SHA256)  $@'
