FROM golang:1.21-alpine3.18 AS golang
FROM alpine:3.18 AS runtime
# Download binaries
FROM golang AS builder
ENV GO111MODULE on
RUN apk add git
RUN go install github.com/google/go-jsonnet/cmd/jsonnet@v0.20.0
RUN go install -a github.com/jsonnet-bundler/jsonnet-bundler/cmd/jb@v0.5.1
# Build our final image
FROM runtime
COPY --from=builder /go/bin/jsonnet /usr/local/bin/jsonnet
COPY --from=builder /go/bin/jb /usr/local/bin/jb
RUN apk add bash make git yq
WORKDIR /app
