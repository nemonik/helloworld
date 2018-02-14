# Copyright (C) 2018 Michael Joseph Walsh - All Rights Reserved
# You may use, distribute and modify this code under the
# terms of the the license.
#
# You should have received a copy of the license with
# this file. If not, please email <mjwalsh@nemonik.com>

GOCMD=go
GOFMT=$(GOCMD) fmt
GOBUILD=$(GOCMD) build
GOCLEAN=$(GOCMD) clean
GOTEST=$(GOCMD) test
GOGET=$(GOCMD) get
BINARY_NAME=helloworld

SONAR_DEPENDENCIES := \
	gopkg.in/alecthomas/gometalinter.v1 \
	github.com/axw/gocov/... \
	github.com/AlekSi/gocov-xml \
	github.com/jstemmer/go-junit-report

all: fmt lint test build
clean:
	$(GOCLEAN)
	rm -f $(BINARY_NAME)
fmt:
	$(GOFMT)
lint:
	$(GOGET) github.com/golang/lint/golint
	golint
test: 
	$(GOTEST) -v ./...
build:
	$(GOBUILD) -o $(BINARY_NAME) -v
run:
	$(GOBUILD) -o $(BINARY_NAME) -v ./...
	./$(BINARY_NAME)
sonar:
	$(GOGET) $(SONAR_DEPENDENCIES)
	gometalinter.v1 --install
	-gometalinter.v1 --checkstyle > report.xml
	-gocov test ./... | gocov-xml > coverage.xml
	-$(GOTEST) -v ./... | go-junit-report > test.xml
#	sonar-scanner -D sonar.projectKey=helloworld -D sonar.projectName=helloworld -D sonar.projectVersion=1.0 -D sonar.sources=. -D sonar.golint.reportPath=report.xml -D sonar.coverage.reportPath=coverage.xml -D sonar.coverage.dtdVerification=false -D sonar.test.reportPath=test.xml
#docker-build:
#	docker build

