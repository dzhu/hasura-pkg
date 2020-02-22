#!/bin/bash

set -ex

version="${1:-1.0.0}"

# Create an "upstream tarball" in a fresh directory.
rm -rf build
mkdir build
tar czf build/hasura-"$version".tar.gz hasura-"$version"
cd build

# Now work with the tarball normally.
tar xf hasura-"$version".tar.gz
cp -rp ../debian hasura-"$version"
# Hack: edit the version in the changelog, since it's supposed to match the
# package version.
sed -i "s|hasura (.*)|hasura ($version-1)|" hasura-"$version"/debian/changelog
cat hasura-"$version"/debian/changelog
ln -s hasura-"$version".tar.gz hasura_"$version".orig.tar.gz

owner="$(id -u)":"$(id -g)"
ubuntu_version="${ubuntu_version:-18.04}"

docker run \
  --rm \
  -v "$PWD":/tmp/build \
  local/pkg-dev \
  sh -c "echo \"$owner\" \"$version\" && cd /tmp/build/hasura-\"$version\" && debuild && chown -R \"$owner\" .. && debian/rules clean"

tree
dpkg -c ./*.deb
