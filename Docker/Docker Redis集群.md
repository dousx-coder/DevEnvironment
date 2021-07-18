# Docker部署Redis集群

## 1.创建redis自定义集群网卡及查看 

```shell
[root@centos data]# docker network create redis --subnet 172.38.0.0/16
14e37cd6a2ef85ffb12c469af5b19b94ecf92bb1b257caf9b7676cd8c221a942
[root@centos data]# docker network ls
NETWORK ID     NAME      DRIVER    SCOPE
333203a3f1b8   bridge    bridge    local
8aff6011c1e2   host      host      local
e47411ee61ec   none      null      local
14e37cd6a2ef   redis     bridge    local
[root@centos data]# docker network inspect redis
[
    {
        "Name": "redis",
        "Id": "14e37cd6a2ef85ffb12c469af5b19b94ecf92bb1b257caf9b7676cd8c221a942",
        "Created": "2021-07-18T14:21:24.787316197+08:00",
        "Scope": "local",
        "Driver": "bridge",
        "EnableIPv6": false,
        "IPAM": {
            "Driver": "default",
            "Options": {},
            "Config": [
                {
                    "Subnet": "172.38.0.0/16"
                }
            ]
        },
        "Internal": false,
        "Attachable": false,
        "Ingress": false,
        "ConfigFrom": {
            "Network": ""
        },
        "ConfigOnly": false,
        "Containers": {},
        "Options": {},
        "Labels": {}
    }
]
[root@centos data]#
```

## 2.redis节点创建及设置

>创建redis config脚本

```sh
for port in $(seq 1 6);
do
mkdir -p /data/redis/node-${port}/conf
touch /data/redis/node-${port}/conf/redis.conf
cat << EOF >/data/redis/node-${port}/conf/redis.conf
port 6379
bind 0.0.0.0
cluster-enabled yes
cluster-config-file nodes.conf
cluster-node-timeout 5000
cluster-announce-ip 172.38.0.1${port}
cluster-announce-port 6379
cluster-announce-bus-port 16379
appendonly yes
EOF
done 
```
>  创建节点脚本

```shell
for port in $(seq 1 6);
do
	docker run -p 637${port}:6379 -p 1637${port}:16379 --name redis-${port} \
 -v /data/redis/node-${port}/data:/data \
 -v /data/redis/node-${port}/conf/redis.conf:/etc/redis/redis.conf \
 -d --net redis --ip 172.38.0.1${port} redis:5.0.9-alpine3.11 redis-server /etc/redis/redis.conf
done
```

## 3.创建集群

```shell
# 以交互模式进入redis节点内
docker exec -it redis-1 /bin/sh
# 创建集群
redis-cli --cluster create \
172.38.0.11:6379 \
172.38.0.12:6379 \
172.38.0.13:6379 \
172.38.0.14:6379 \
172.38.0.15:6379 \
172.38.0.16:6379 \
--cluster-replicas 1
```

> 出现如下结果成功

```sh
[root@centos data]# docker exec -it redis-1 /bin/sh
/data # redis-cli --cluster create \
> 172.38.0.11:6379 \
> 172.38.0.12:6379 \
> 172.38.0.13:6379 \
> 172.38.0.14:6379 \
> 172.38.0.15:6379 \
> 172.38.0.16:6379 \
> --cluster-replicas 1
>>> Performing hash slots allocation on 6 nodes...
Master[0] -> Slots 0 - 5460
Master[1] -> Slots 5461 - 10922
Master[2] -> Slots 10923 - 16383
Adding replica 172.38.0.15:6379 to 172.38.0.11:6379
Adding replica 172.38.0.16:6379 to 172.38.0.12:6379
Adding replica 172.38.0.14:6379 to 172.38.0.13:6379
M: 4684ecfa840473774ab4a511db81195339101af4 172.38.0.11:6379
   slots:[0-5460] (5461 slots) master
M: aac2e247f6060a876c3a7edbbc96fd779f9d9b62 172.38.0.12:6379
   slots:[5461-10922] (5462 slots) master
M: 72d6df90f1efed560579a51beeab56d514ceb04a 172.38.0.13:6379
   slots:[10923-16383] (5461 slots) master
S: 90ca4e2ead6b6404dae7ce6f9fca058109a5825f 172.38.0.14:6379
   replicates 72d6df90f1efed560579a51beeab56d514ceb04a
S: 4903bd202cc0fec5edbbd5c008779c62abae6788 172.38.0.15:6379
   replicates 4684ecfa840473774ab4a511db81195339101af4
S: 406aa8a62807b11ada9f807649cfff78fad85c27 172.38.0.16:6379
   replicates aac2e247f6060a876c3a7edbbc96fd779f9d9b62
Can I set the above configuration? (type 'yes' to accept): yes
>>> Nodes configuration updated
>>> Assign a different config epoch to each node
>>> Sending CLUSTER MEET messages to join the cluster
Waiting for the cluster to join
.
>>> Performing Cluster Check (using node 172.38.0.11:6379)
M: 4684ecfa840473774ab4a511db81195339101af4 172.38.0.11:6379
   slots:[0-5460] (5461 slots) master
   1 additional replica(s)
S: 90ca4e2ead6b6404dae7ce6f9fca058109a5825f 172.38.0.14:6379
   slots: (0 slots) slave
   replicates 72d6df90f1efed560579a51beeab56d514ceb04a
S: 4903bd202cc0fec5edbbd5c008779c62abae6788 172.38.0.15:6379
   slots: (0 slots) slave
   replicates 4684ecfa840473774ab4a511db81195339101af4
M: 72d6df90f1efed560579a51beeab56d514ceb04a 172.38.0.13:6379
   slots:[10923-16383] (5461 slots) master
   1 additional replica(s)
M: aac2e247f6060a876c3a7edbbc96fd779f9d9b62 172.38.0.12:6379
   slots:[5461-10922] (5462 slots) master
   1 additional replica(s)
S: 406aa8a62807b11ada9f807649cfff78fad85c27 172.38.0.16:6379
   slots: (0 slots) slave
   replicates aac2e247f6060a876c3a7edbbc96fd779f9d9b62
[OK] All nodes agree about slots configuration.
>>> Check for open slots...
>>> Check slots coverage...
[OK] All 16384 slots covered.
/data # 

```

