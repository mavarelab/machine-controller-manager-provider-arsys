#############      builder                                  #############
FROM golang:1.13.5 AS builder

WORKDIR /go/src/github.com/mavarelab/machine-controller-manager-provider-arsys
COPY . .

RUN .ci/build

#############      base                                     #############
FROM alpine:3.11.2 as base

RUN apk add --update bash curl tzdata
WORKDIR /

#############      machine-controller               #############
FROM base AS machine-controller

COPY --from=builder /go/src/github.com/mavarelab/machine-controller-manager-provider-arsys/bin/rel/machine-controller /machine-controller
ENTRYPOINT ["/machine-controller"]
