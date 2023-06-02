# Docker常用命令
> Docker拉去镜像默认latest，应该指定版本
#### 查询容器独立ip
```sh
docker inspect --format='{{.NetworkSettings.IPAddress}}' 容器id或者名称
```
#### 从容器中拷贝文件到宿主机
```sh
docker cp mysql801:/etc/mysql/my.cnf /opt/dockerSoftware/my.cnf
```
#### 从宿主机拷贝文件到容器
```sh
docker cp /opt/dockerSoftware/my.cnf mysql802:/etc/mysql/my.cnf
```
#### ps查看指定的列
```sh
docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Ports}}\t{{.Status}}" -a
```
#### 设置容器随docker启动自启
```sh
docker update --restart=always CONTAINER ID
```
#### 设置所有容器随docker启动而启动
```sh
docker update --restart=always $(docker ps -q)
```

#### 设置所有容器不随docker启动而启动
```sh
docker update --restart=no $(docker ps -q)
```

#### 停止所有容器
```sh
docker stop $(docker ps -a -q)
```
#### 删除所有容器
```sh
docker rm $(docker ps -a -q)
```
#### 停止所有容器并删除所有容器
```sh
docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q)
```
#### 镜像压缩
```sh
# 将pinpoint images压缩到p.tar里
docker save -o p.tar pinpointdocker/pinpoint-hbase:2.3.3 pinpointdocker/pinpoint-mysql:2.3.3 pinpointdocker/pinpoint-flink:2.3.3 pinpointdocker/pinpoint-collector:2.3.3 pinpointdocker/pinpoint-agent:2.3.3 pinpointdocker/pinpoint-quickstart:latest pinpointdocker/pinpoint-web:2.3.3 zookeeper:3.4
# 通过tar加载镜像
docker load<p.tar 
```

