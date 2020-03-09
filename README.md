* If you have the Debian packaging tools installed, run `make-pkg.sh <hasura-version>`.
* Otherwise, run `make-dev-img.sh` to build an Ubuntu image with the tools installed and
  `make-pkg-docker.sh <hasura-version>` to build the package inside that image.
* Run `test.sh <hasura-version>` to install and run Hasura inside a fresh image using the newly
  created package. If Hasura starts printing log messages rather than an error about `libpq`, then
  you're probably good to go (though of course it won't actually work unless you also have Postgres
  with suitable schema running).

Taking the Hasura binary directly from an image and using it elsewhere is, shall we say,
semi-officially endorsed: https://github.com/hasura/graphql-engine/issues/2729.
