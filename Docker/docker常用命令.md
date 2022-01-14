# Docker常用命令
```sh
--name:为容器指定名称
-it:启动一个交互型容器，此参数为我们和容器提供了一个交互shell
-d:创建后台型容器
--restart=always:容器退出后自动重启
--restart=on-failure:x:容器退出时如果返回值是非0，就会尝试重启x次
-p x:y :主机端口：容器端口
-P：随机分配一个49000到49900的端口
-v：创建数据卷
-n :指定dns
-h : 指定容器的hostname
-e ：设置环境变量
-m :设置容器使用内存最大值
--net: 指定容器的网络连接类型，支持 bridge/host/none/container
--link=x: 添加链接到另一个容器x
--expose=x: 开放端口x
```

```shell
#查询容器独立ip
docker inspect --format='{{.NetworkSettings.IPAddress}}' 容器id或者名称
```

```shell
# 从容器中拷贝文件到宿主机
docker cp mysql801:/etc/mysql/my.cnf /opt/dockerSoftware/my.cnf

# 从宿主机拷贝文件到容器
docker cp /opt/dockerSoftware/my.cnf mysql802:/etc/mysql/my.cnf
```

```sh
# ps查看指定的列
docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Ports}}\t{{.Status}}" -a
docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Status}}" -a
```

```sh
# 设置容器随docker启动自启
docker update --restart=always CONTAINER ID
# 设置所有容器随docker启动而启动
docker update --restart=always $(docker ps -q)
```

```sh
# 将pinpoint images压缩到p.tar里
docker save -o p.tar pinpointdocker/pinpoint-hbase:2.3.3 pinpointdocker/pinpoint-mysql:2.3.3 pinpointdocker/pinpoint-flink:2.3.3 pinpointdocker/pinpoint-collector:2.3.3 pinpointdocker/pinpoint-agent:2.3.3 pinpointdocker/pinpoint-quickstart:latest pinpointdocker/pinpoint-web:2.3.3 zookeeper:3.4
# 通过tar加载镜像
docker load<p.tar 
```

