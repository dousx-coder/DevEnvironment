#!/bin/bash

docker pull redis:6.2.4 

docker network create redis --subnet 172.38.0.0/16

echo "create redis conf..."
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


echo "create redis container..."
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


for port in $(seq 1 3);
do
docker exec  redis-${port}  redis-cli info replication
done

# --------------------------------------------------------------------


echo "create sentinel config..."
for port in $(seq 1 3);
do
mkdir -p /data/redis/sentinel-${port}/conf
touch /data/redis/sentinel-${port}/conf/sentinel.conf
cat << EOF >/data/redis/sentinel-${port}/conf/sentinel.conf
port 26379
sentinel monitor redis-nodes 172.38.0.11 6379 2
protected-mode no
sentinel down-after-milliseconds redis-nodes 30000
sentinel deny-scripts-reconfig yes
EOF
done 


echo "create sentinel container..."
for port in $(seq 1 3);
do
 docker run -p 2637${port}:26379  --name redis-sentinel-${port} \
 -v /data/redis/sentinel-${port}/conf/sentinel.conf:/etc/redis/sentinel.conf  \
 -d --net redis --ip 172.38.0.2${port} redis:6.2.4  redis-sentinel /etc/redis/sentinel.conf 
done


echo "done..."