#!/bin/sh

#start all services for course
docker-compose -f "$(pwd)"/skillbox_db_env/docker-compose.yaml up -d
for i in {1..25}
do
  mysqlIsAvailable="$(docker logs skillbox-mysql 2>&1 | grep 'CA certificate ca.pem is self signed'.)"
  if [ "$mysqlIsAvailable" ]; then
    sleep 10;
    docker exec -i skillbox-mysql mysql -uskillbox -pskillbox <"$(pwd)"/skillbox_db_env/example-data/mysql/schema.sql
    docker exec -i skillbox-mysql mysql -uskillbox -pskillbox <"$(pwd)"/skillbox_db_env/example-data/mysql/data.sql
    echo "Data migrated successful into mysql container!"
    break
  fi
    echo "Attempt $i. Waiting start mysql container ..."
    sleep 2;
done