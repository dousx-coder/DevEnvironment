#!/bin/bash
rm /data/redis/ -rf
echo "create redis conf..."
for port in $(seq 1 3);
do
mkdir -p /data/redis/node-${port}/conf
touch /data/redis/node-${port}/conf/redis.conf
cat << EOF >/data/redis/node-${port}/conf/redis.conf
port 6379
bind 0.0.0.0
replica-announce-ip 172.20.0.1${port}
slaveof 172.20.0.11 6379
appendonly no
EOF
done
sed -i 's/slaveof 172.20.0.11 6379//g' /data/redis/node-1/conf/redis.conf

# --------------------------------------------------------------------


echo "create sentinel config..."
for port in $(seq 1 3);
do
mkdir -p /data/redis/sentinel-${port}/conf
touch /data/redis/sentinel-${port}/conf/sentinel.conf
cat << EOF >/data/redis/sentinel-${port}/conf/sentinel.conf
port 26379
sentinel monitor redis-nodes 172.20.0.11 6379 2
protected-mode no
sentinel down-after-milliseconds redis-nodes 30000
sentinel deny-scripts-reconfig yes
EOF
done


echo "done..."