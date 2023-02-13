# Docker 搭建redis主从

## 配置主从说明
命令`slaveof <ip> <prot>`
- 方式一 config文件中配置(永久)
- 方式二 命令配置(重启失效)

## 拉取镜像
```sh
docker pull redis:6.2.4 
```
## 创建network
```sh
docker network create redis --subnet 172.38.0.0/16
```

## redis节点配置

>创建`redis-config.sh`脚本
>
>`replica-announce-ip 172.38.0.11`声明redis的ip

```sh
#!/bin/bash

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
```
执行
```sh
sudo chmod +x redis-config.sh && sudo sh redis-config.sh
```
## 创建节点

>  创建redis-node.sh节点脚本

```sh
#!/bin/bash

for port in $(seq 1 3);
do
 docker run -p 637${port}:6379  --name redis-${port} \
 -v /data/redis/node-${port}/data:/data \
 -v /data/redis/node-${port}/conf/redis.conf:/etc/redis/redis.conf \
 -d --net redis --ip 172.38.0.1${port} redis:6.2.4  redis-server /etc/redis/redis.conf
done
```

```sh
sudo chmod +x redis-node.sh && sudo sh redis-node.sh
```

## 命令配置主从
```
docker exec -it redis-2 /bin/sh
redis-cli 
slaveof 172.38.0.11 6379
```

或者
```sh
docker exec  redis-2  redis-cli  slaveof 172.38.0.11 6379
docker exec  redis-3  redis-cli  slaveof 172.38.0.11 6379
```