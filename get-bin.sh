version="${1:-1.0.0}"

img_id=$(docker create hasura/graphql-engine:v"$version")
mkdir -p hasura-"$version"
docker cp "$img_id":/bin/graphql-engine hasura-"$version"/
docker rm "$img_id" > /dev/null
