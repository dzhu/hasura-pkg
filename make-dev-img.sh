#!/bin/bash

ubuntu_version="${ubuntu_version:-18.04}"

docker build -t local/pkg-dev:"$ubuntu_version" - <<EOF
FROM ubuntu:"$ubuntu_version"
RUN apt-get -y update && apt-get install -y libpq-dev debmake debhelper docker.io
EOF
