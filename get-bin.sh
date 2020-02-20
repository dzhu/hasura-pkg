img_id=$(docker create hasura/graphql-engine:v1.1.0)
mkdir -p bin
docker cp "$img_id":/bin/graphql-engine hasura-1.1.0/bin
docker rm "$img_id" > /dev/null
