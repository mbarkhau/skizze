GOPATH=$(CURDIR)/vendor:$(CURDIR)

VERSION = 0.0.2

all: bake-config skizze skizze-cli

bake-config:
	@GOPATH=$(GOPATH) && \
	  go generate src/config/config.go > src/config/config.go.tmp
	@mv src/config/config.go.tmp src/config/config.go

skizze:
	@GOPATH=$(GOPATH) && \
	  go build -a -v -ldflags "-w -X main.version=${VERSION}" -o ./bin/skizze ./src/skizze

skizze-cli:
	@GOPATH=$(GOPATH) && \
	  go build -a -v -ldflags "-w -X skizze-cli/bridge.version=${VERSION}"  -o ./bin/skizze-cli ./src/skizze-cli

build-dep:
	@go get github.com/constabulary/gb/...

vendor:
	@gb vendor restore

test:
	@GOPATH=$(GOPATH) && go test -race -cover ./src/...

bench:
	@GOPATH=$(GOPATH) && go test -bench=. ./src/...

proto:
	@protoc --go_out=plugins=grpc:. ./src/datamodel/protobuf/skizze.proto

dist: build-dep vendor all

setup-lint:
	@GOPATH=$(GOPATH) && \
		go get github.com/alecthomas/gometalinter
	@GOPATH=$(GOPATH) && \
		gometalinter --install --update

lint:
	@GOPATH=$(GOPATH) && \
		gometalinter ./src/* -D gocyclo -D gotype -D dupl --deadline=5s

clean:
	@rm ./bin/*

.PHONY: all build-dep vendor test dist clean

