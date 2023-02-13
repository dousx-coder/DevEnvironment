#!/bin/bash

docker pull redis:6.2.4 

docker network create redis --subnet 172.38.0.0/16

echo "create redis.conf..."
for port in $(seq 1 3);
do
mkdir -p /data/redis/node-${port}/conf
touch /data/redis/node-${port}/conf/redis.conf
cat << EOF >/data/redis/node-${port}/conf/redis.conf
port 6379
bind 0.0.0.0
replica-announce-ip 172.38.0.1${port}
appendonly no
EOF
done 


echo "create container..."
for port in $(seq 1 3);
do
 docker run -p 637${port}:6379  --name redis-${port} \
 -v /data/redis/node-${port}/data:/data \
 -v /data/redis/node-${port}/conf/redis.conf:/etc/redis/redis.conf \
 -d --net redis --ip 172.38.0.1${port} redis:6.2.4  redis-server /etc/redis/redis.conf
done

echo "slaveof..."
for port in $(seq 2 3);
do
 docker exec  redis-${port}  redis-cli  slaveof 172.38.0.11 6379
done

echo "done..."