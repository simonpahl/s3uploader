UID = $(shell id -u)
GID = $(shell id -g)
PKGNAME = "github.com/simonpahl/s3uploader"
PKGPATH = "/go/src/$(PKGNAME)"
GOCACHE = ".gocache"
GOLANGIMAGE = "golang:1.9"
GOEXEC = docker run -it -u $(UID):$(GID) -v $(PWD)/$(GOCACHE):/go --rm -v $(PWD):$(PKGPATH) -w $(PKGPATH) $(GOLANGIMAGE)

build: ensure
	@-$(GOEXEC) go build -v -ldflags="-s -w"

console: dep
	@-echo "Opening Console"
	@-$(GOEXEC) bash

ensure: dep
	@-echo "Ensuring dependencies are installed"
	@-$(GOEXEC) dep ensure

dep: prepare
	@-echo "Installing Dep"
	@-$(GOEXEC) go get -u github.com/golang/dep/cmd/dep

prepare:
	@-echo "Preparing GOPATH"
	@-mkdir -p .gocache/src/$(PKGNAME)

clean:
	@-rm -rf .gocache vendor
	@-rm -f s3uploader