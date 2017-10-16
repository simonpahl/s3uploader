UID = $(shell id -u)
GID = $(shell id -g)
PKGNAME = "s3uploader"
PKGPATH = "/go/src/$(PKGNAME)"
GOCACHE = ".gocache"
GOLANGIMAGE = "golang:1.9"
GOEXEC = docker run -it -u $(UID):$(GID) -v $(PWD)/$(GOCACHE):/go --rm -v $(PWD):$(PKGPATH) -w $(PKGPATH) $(GOLANGIMAGE)

build:
	@-$(GOEXEC) go build -v

console: tools
	@-$(GOEXEC) bash

tools:
	@-mkdir -p .gocache/src
	@-$(GOEXEC) go get -u github.com/kardianos/govendor

clean:
	@-rm -rf .gocache
	@-rm -f s3uploader