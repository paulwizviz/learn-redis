ARG OS_VER
ARG GO_VER

## Building Redis server from source
FROM ${OS_VER} as redisbuilder

RUN apt-get update && \
    apt-get install -y build-essential wget && \
    cd /opt && \
    wget https://download.redis.io/redis-stable.tar.gz && \
    tar -xvf redis-stable.tar.gz && \
    cd redis-stable && \
    make && \
    make install

## Build a simple cli app interacting with an Redis server
FROM golang:${GO_VER} as gobuilder

WORKDIR /opt

COPY ./go.mod ./go.mod
COPY ./go.sum ./go.sum

COPY ./cmd ./cmd

RUN go mod download && \
    go build -o ./build/bin/redisclient ./cmd/embed

## Package redis and REST API to this image
FROM ${OS_VER}

COPY --from=redisbuilder /usr/local/bin/redis-cli /usr/local/bin/redis-cli
COPY --from=redisbuilder /usr/local/bin/redis-server /usr/local/bin/redis-server
COPY --from=redisbuilder /usr/local/bin/redis-benchmark /usr/local/bin/redis-benchmark

COPY --from=gobuilder /opt/build/bin/redisclient /usr/local/bin/redisclient

