#!/bin/bash
rm /data/redis/ -rf

vmIp=192.168.96.151

# redis节点密码
redisNodePassWd=node_1fsgg23vK2_3

echo "create redis conf..."
for port in $(seq 1 3);
do
mkdir -p /data/redis/node-${port}/conf
touch /data/redis/node-${port}/conf/redis.conf
cat << EOF >/data/redis/node-${port}/conf/redis.conf
port 6379
bind 0.0.0.0
requirepass ${redisNodePassWd}
masterauth ${redisNodePassWd}
slaveof ${vmIp} 6371
appendonly no
slave-announce-ip ${vmIp}
slave-announce-port 637${port}
EOF
done
sed -i "s/slaveof ${vmIp} 6371//g" /data/redis/node-1/conf/redis.conf

# --------------------------------------------------------------------


echo "create sentinel config..."
for port in $(seq 1 3);
do
mkdir -p /data/redis/sentinel-${port}/conf
touch /data/redis/sentinel-${port}/conf/sentinel.conf
cat << EOF >/data/redis/sentinel-${port}/conf/sentinel.conf
port 26379
sentinel monitor redis-nodes ${vmIp} 6371 2
sentinel auth-pass redis-nodes ${redisNodePassWd}
protected-mode no
sentinel down-after-milliseconds redis-nodes 30000
sentinel deny-scripts-reconfig yes
sentinel announce-ip ${vmIp}
sentinel announce-port 2637${port}
EOF
done

chmod -R 0777 /data/redis
echo "done..."
