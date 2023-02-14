# Docker配置Redis哨兵&主从

## Docker配置Redis哨兵&主从
`docker-redis-sentinel-slaveof.sh`脚本内容如下
```sh
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
```


```
sudo chmod +x docker-redis-sentinel-slaveof.sh && sudo sh docker-redis-sentinel-slaveof.sh
```

## 哨兵日志
```sh
1:X 14 Feb 2023 02:04:14.950 # oO0OoO0OoO0Oo Redis is starting oO0OoO0OoO0Oo
1:X 14 Feb 2023 02:04:14.950 # Redis version=6.2.4, bits=64, commit=00000000, modified=0, pid=1, just started
1:X 14 Feb 2023 02:04:14.950 # Configuration loaded
1:X 14 Feb 2023 02:04:14.962 * monotonic clock: POSIX clock_gettime
1:X 14 Feb 2023 02:04:14.964 * Running mode=sentinel, port=26379.
1:X 14 Feb 2023 02:04:14.971 # Could not rename tmp config file (Device or resource busy)
1:X 14 Feb 2023 02:04:14.971 # WARNING: Sentinel was not able to save the new configuration on disk!!!: Device or resource busy
1:X 14 Feb 2023 02:04:14.971 # Sentinel ID is 3cf8c69209d6ddf29b51550e5b7c22409b031e3a
1:X 14 Feb 2023 02:04:14.971 # +monitor master redis-nodes 172.38.0.11 6379 quorum 2
1:X 14 Feb 2023 02:04:14.972 * +slave slave 172.38.0.12:6379 172.38.0.12 6379 @ redis-nodes 172.38.0.11 6379
1:X 14 Feb 2023 02:04:14.974 # Could not rename tmp config file (Device or resource busy)
1:X 14 Feb 2023 02:04:14.975 # WARNING: Sentinel was not able to save the new configuration on disk!!!: Device or resource busy
1:X 14 Feb 2023 02:04:14.975 * +slave slave 172.38.0.13:6379 172.38.0.13 6379 @ redis-nodes 172.38.0.11 6379
1:X 14 Feb 2023 02:04:14.978 # Could not rename tmp config file (Device or resource busy)
1:X 14 Feb 2023 02:04:14.979 # WARNING: Sentinel was not able to save the new configuration on disk!!!: Device or resource busy
1:X 14 Feb 2023 02:04:18.780 * +sentinel sentinel 9fc55bce233cad24b5d4fc0623b4990e66280706 172.38.0.22 26379 @ redis-nodes 172.38.0.11 6379
1:X 14 Feb 2023 02:04:18.782 # Could not rename tmp config file (Device or resource busy)
1:X 14 Feb 2023 02:04:18.782 # WARNING: Sentinel was not able to save the new configuration on disk!!!: Device or resource busy
1:X 14 Feb 2023 02:04:20.678 * +sentinel sentinel e48dd0b96690f9ca0b53e599c8c896e7947a041a 172.38.0.23 26379 @ redis-nodes 172.38.0.11 6379
1:X 14 Feb 2023 02:04:20.685 # Could not rename tmp config file (Device or resource busy)
1:X 14 Feb 2023 02:04:20.685 # WARNING: Sentinel was not able to save the new configuration on disk!!!: Device or resource busy
1:X 14 Feb 2023 02:08:54.955 # +sdown master redis-nodes 172.38.0.11 6379
1:X 14 Feb 2023 02:08:54.995 # Could not rename tmp config file (Device or resource busy)
1:X 14 Feb 2023 02:08:54.996 # WARNING: Sentinel was not able to save the new configuration on disk!!!: Device or resource busy
1:X 14 Feb 2023 02:08:54.996 # +new-epoch 1
1:X 14 Feb 2023 02:08:54.998 # Could not rename tmp config file (Device or resource busy)
1:X 14 Feb 2023 02:08:54.999 # WARNING: Sentinel was not able to save the new configuration on disk!!!: Device or resource busy
1:X 14 Feb 2023 02:08:54.999 # +vote-for-leader 9fc55bce233cad24b5d4fc0623b4990e66280706 1
1:X 14 Feb 2023 02:08:55.009 # +odown master redis-nodes 172.38.0.11 6379 #quorum 3/2
1:X 14 Feb 2023 02:08:55.009 # Next failover delay: I will not start a failover before Tue Feb 14 02:14:55 2023
1:X 14 Feb 2023 02:08:56.130 # +config-update-from sentinel 9fc55bce233cad24b5d4fc0623b4990e66280706 172.38.0.22 26379 @ redis-nodes 172.38.0.11 6379
1:X 14 Feb 2023 02:08:56.130 # +switch-master redis-nodes 172.38.0.11 6379 172.38.0.13 6379
1:X 14 Feb 2023 02:08:56.130 * +slave slave 172.38.0.12:6379 172.38.0.12 6379 @ redis-nodes 172.38.0.13 6379
1:X 14 Feb 2023 02:08:56.130 * +slave slave 172.38.0.11:6379 172.38.0.11 6379 @ redis-nodes 172.38.0.13 6379
1:X 14 Feb 2023 02:08:56.136 # Could not rename tmp config file (Device or resource busy)
1:X 14 Feb 2023 02:08:56.136 # WARNING: Sentinel was not able to save the new configuration on disk!!!: Device or resource busy
1:X 14 Feb 2023 02:09:26.137 # +sdown slave 172.38.0.11:6379 172.38.0.11 6379 @ redis-nodes 172.38.0.13 6379
```