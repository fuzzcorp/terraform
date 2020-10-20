# This Dockerfile builds on golang:alpine by building Terraform from source
# using the current working directory.
#
# This produces a docker image that contains a working Terraform binary along
# with all of its source code.

FROM golang:alpine
LABEL maintainer="HashiCorp Terraform Team <terraform@hashicorp.com>"

RUN apk add --no-cache git bash openssh

ENV TF_DEV=true
ENV TF_RELEASE=1

WORKDIR $GOPATH/src/github.com/hashicorp/terraform
COPY . .
RUN /bin/bash ./scripts/build.sh

WORKDIR $GOPATH
ENTRYPOINT ["terraform"]
