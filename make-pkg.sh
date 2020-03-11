#!/bin/bash

set -ex

version="${1:-1.0.0}"

if [ ! -f bin/graphql-engine-"$version" ]; then
  mkdir -p bin
  img_id=$(docker create hasura/graphql-engine:v"$version")
  docker cp "$img_id":/bin/graphql-engine bin/graphql-engine-"$version"
  docker rm "$img_id" >/dev/null
fi

rm -rf build
mkdir -p build/hasura
cp bin/graphql-engine-"$version" build/hasura/graphql-engine
cd build/hasura

cp -rp ../../debian .
# Hack: edit the version in the changelog, since it's supposed to match the
# package version. (Normally there would actually be an updated changelog for
# each version, but we're just using one file for simplicity.)
sed -i "s|hasura (.*)|hasura ($version-1)|" debian/changelog

dpkg-buildpackage -rfakeroot -us -uc -ui -b
debian/rules clean

cd ..
ls -R
dpkg -c ./*.deb
