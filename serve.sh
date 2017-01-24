#!/bin/bash

DOCKER_IP="10.0.0.164"


docker build -t corts/drcon .


docker run -d -h node -p 8500:8500 -p 8600:53/udp progrium/consul -server -bootstrap -advertise $DOCKER_IP -log-level debug
docker run -d -v /var/run/docker.sock:/tmp/docker.sock -h $DOCKER_IP gliderlabs/registrator consul://$DOCKER_IP:8500

docker run -d --name cloudwatchlogs liveauctioneers/ecs-cloudwatch-logs:27

cd ../mainhost-prod && ./docker-run.sh --build 255 --app mainhost-api
cd ../bidder-prod && ./docker-run.sh --build 15
cd ../savedsearch-prod && ./docker-run.sh --build 4

docker run -d -e "CONSUL=$DOCKER_IP:8500" -p 80:80 corts/drcon

docker ps

