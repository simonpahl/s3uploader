UID = $(shell id -u)
GID = $(shell id -g)
PKGNAME = "github.com/simonpahl/s3uploader"
PKGPATH = "/go/src/$(PKGNAME)"
GOCACHE = ".gocache"
GOLANGIMAGE = "golang:1.9"
GOEXEC = docker run -it -u $(UID):$(GID) -v $(PWD)/$(GOCACHE):/go --rm -v $(PWD):$(PKGPATH) -w $(PKGPATH) $(GOLANGIMAGE)

build: ensure
	@-$(GOEXEC) go build -v -ldflags="-s -w"

console: tools
	echo "Opening Console"
	@-$(GOEXEC) bash

ensure: tools
	echo "Ensuring dependencies are installed"
	@-$(GOEXEC) dep ensure

tools:
	echo "Ensuring dependencies are installed"
	@-mkdir -p .gocache/src/$(PKGNAME)
	@-$(GOEXEC) go get -u github.com/golang/dep/cmd/dep

clean:
	@-rm -rf .gocache vendor
	@-rm -f s3uploader