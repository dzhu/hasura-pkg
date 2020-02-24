version="${1:-1.0.0}"

mkdir -p bin

img_id=$(docker create hasura/graphql-engine:v"$version")
docker cp "$img_id":/bin/graphql-engine bin/graphql-engine-"$version"
docker rm "$img_id" > /dev/null
