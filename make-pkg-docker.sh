#!/bin/sh

docker run --rm -v /var/run/docker.sock:/var/run/docker.sock -v "$PWD":/hasura local/pkg-dev:18.04 sh -c "cd /hasura && ./make-pkg.sh $*"
