version="${1:-1.0.0}"
ubuntu_version="${ubuntu_version:-18.04}"

docker run --init --rm \
  -p 127.0.0.1:8081:8080 \
  -v "$PWD"/build/hasura_"$version"-1_amd64.deb:/tmp/hasura.deb \
  -e HASURA_GRAPHQL_DATABASE_URL \
  -e HASURA_GRAPHQL_ENABLE_CONSOLE=true \
  -e HASURA_GRAPHQL_ENABLE_TELEMETRY=false \
  "$@" \
  ubuntu:"$ubuntu_version" \
  sh -c 'apt-get update && apt-get install -y --no-install-recommends /tmp/hasura.deb && dpkg -L hasura && hasura serve'
