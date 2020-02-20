* Run `get-bin.sh` to pull the Hasura binary out of a Docker image.
* Run `make-dev-img.sh` to build an Ubuntu image with package build tools installed.
* Run `make-pkg.sh` to build the .deb package inside that image.
* Run `test.sh` to install and run Hasura inside a fresh image using the newly created package. If
  Hasura starts printing log messages rather than an error about `libpq`, then you're probably good
  to go (though of course it won't actually work unless you also have Postgres with suitable schema
  running).

Taking the Hasura binary directly from an image and using it elsewhere is, shall we say,
semi-officially endorsed: https://github.com/hasura/graphql-engine/issues/2729.
