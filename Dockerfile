#--- Build stage
FROM golang:1.22-bullseye AS go-builder

WORKDIR /src

COPY . /src/

RUN make build CGO_ENABLED=0

#--- Image stage
FROM alpine:3.21.3

COPY --from=go-builder /src/target/dist/jackal-auth-proxy /usr/bin/jackal-auth-proxy

WORKDIR /opt

ENTRYPOINT ["/usr/bin/jackal-auth-proxy"]
