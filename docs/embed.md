# Embeded example

This example demonstrates:

* The process of creating a Redis server from source code to run in Ubuntu (see [./build/embed.dockerfile](../build/embed.dockerfile)).

* Creating a cli app to interact with a redis server (see [./cmd/embed/main.go](../cmd/embed/main.go))

* Using docker container with an embedded Redis server.

To work with the example use this script [./scripts/compose.sh](../scripts/compose.sh). You need to start the network `./scripts/compose.sh start` and then run `./scripts/compose.sh shell` to access the container.

## Use case 1 

Access the container and interact with Redis as follows:

```
root@<some unique id>/opt#redis-cli
127.0.0.1:6379> ping
PONG
127.0.0.1:6379> SET a 123
OK
127.0.0.1:6379> GET a
"123"
```

## Use case 2

Access the container and run the app `redisclient` as follows:

```
root@0a81e9c2e4a3:/opt# redisclient 
name john
key2 does not exist
```