#!/bin/bash

set -ex

version="${1:-1.0.0}"

if [ ! -f bin/graphql-engine-"$version" ]; then
  mkdir -p bin
  img_id=$(docker create hasura/graphql-engine:v"$version")
  docker cp "$img_id":/bin/graphql-engine bin/graphql-engine-"$version"
  docker rm "$img_id" >/dev/null
fi

# Create an "upstream tarball" in a fresh directory.
rm -rf build
mkdir build
tar czvf build/hasura-"$version".tar.gz --xform "s|.*|hasura-$version/graphql-engine|" bin/graphql-engine-"$version"
cd build

# Now copy in the Debian things and work with the tarball normally.
tar xvf hasura-"$version".tar.gz
cp -rp ../debian hasura-"$version"
# Hack: edit the version in the changelog, since it's supposed to match the
# package version. (Normally there would actually be an updated changelog for
# each version, but we're just using one file for simplicity.)
sed -i "s|hasura (.*)|hasura ($version-1)|" hasura-"$version"/debian/changelog
ln -s hasura-"$version".tar.gz hasura_"$version".orig.tar.gz

cd hasura-"$version"

debuild --no-lintian
debian/rules clean

cd ..
dpkg -c ./*.deb
