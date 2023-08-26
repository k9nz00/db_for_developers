#!/bin/sh

docker-compose -f "$(pwd)"/env/docker-compose.yaml down -v
