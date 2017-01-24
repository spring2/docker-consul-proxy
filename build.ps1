$build="4"

docker build -t spring2/consul-proxy:$build .
docker tag spring2/consul-proxy:$build spring2/consul-proxy:latest
