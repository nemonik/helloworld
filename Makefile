GOCMD=go
GOFMT=$(GOCMD) fmt
GOBUILD=$(GOCMD) build
GOCLEAN=$(GOCMD) clean
GOTEST=$(GOCMD) test
GOLINT=$(GOCMD)lint
GOGET=$(GOCMD) get
BINARY_NAME=helloworld

all: build
clean:
	$(GOCLEAN)
	rm -f $(BINARY_NAME)
fmt:
	$(GOFMT)
lint: fmt
	$(GOGET) golang.org/x/lint/golint
	golint
test: lint
	$(GOTEST) -v -cover ./...
build: test
	$(GOBUILD) -o $(BINARY_NAME) -v
run:
	./$(BINARY_NAME)
