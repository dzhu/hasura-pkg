#!/bin/bash

set -ex

# Create an "upstream tarball" in a fresh directory.
rm -rf build
mkdir build
tar czf build/hasura-1.1.0.tar.gz hasura-1.1.0
cd build

# Now work with the tarball normally.
tar xf hasura-1.1.0.tar.gz
cp -rp ../debian hasura-1.1.0
ln -s hasura-1.1.0.tar.gz hasura_1.1.0.orig.tar.gz

owner="$(id -u)":"$(id -g)"
ubuntu_version="${ubuntu_version:-18.04}"

docker run \
  --rm \
  -v "$PWD":/tmp/build \
  -e owner:"$owner" \
  local/pkg-dev \
  sh -c 'cd /tmp/build/hasura-1.1.0 && debuild && chown -R "$owner" .. && debian/rules clean'

tree
