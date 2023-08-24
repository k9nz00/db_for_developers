#!/bin/sh

#docker-compose -f "$(pwd)"/env/docker-compose.yaml up -d
#
##migrate data into mysql db
#docker exec -i skillbox-mysql mysql -uskillbox -pskillbox <"$(pwd)"/env/example-data/mysql/schema.sql
#docker exec -i skillbox-mysql mysql -uskillbox -pskillbox <"$(pwd)"/env/example-data/mysql/data.sql