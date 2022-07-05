#!/bin/bash

export REDIS_EMBED_IMAGE=go-db/rediscli:current
export REDIS_EMBED_CONTAINER=rediscli
export NETWORK=learn-db_redis

COMMAND="$1"

function build(){
    docker-compose -f ./build/builder.yml build
}

function clean(){
    docker rmi -f ${REDIS_EMBED_IMAGE}
    docker rmi -f $(docker images --filter "dangling=true" -q)
}

case $COMMAND in
    "build")
        build
        ;;
    "clean")
        clean
        ;;
    "shell")
        docker exec -it ${REDIS_EMBED_CONTAINER} /bin/bash
        ;;
    "start")
        docker-compose -f ./deployment/docker-compose.yml up
        ;;
    "stop")
        docker-compose -f ./deployment/docker-compose.yml down
        ;;
    *)
        echo "$0 [ build | clean | shell | start | stop ]"
        ;;
esac