# Docker部署Pinpoint

## 部署Pinpoint

```sh
# CentOS 7安装成功（ubuntu20安装失败，原因待解决）
git clone https://gitee.com/dousx/pinpoint-docker.git
cd pinpoint-docker
# 安装2.1.0版本
git checkout 2.1.0
docker-compose pull && docker-compose up -d
# 手动设置 所有容器随docker启动自启
docker update --restart=always $(docker ps -q)
```

## 访问

```sh
# WebUI
http://192.168.174.181:8079/
# flink
http://192.168.174.181:8081/
# QuickStart
http://192.168.174.181:8000/
# Hbase
http://192.168.174.181:16010/
```

## 安装pinpoint-agent

> 地址
>
> https://github.com/pinpoint-apm/pinpoint/releases/download/v2.1.0/pinpoint-agent-2.1.0.tar.gz

将压缩包上传到服务器，移动到/opt/pinpoint-agent目录

```sh
/opt/pinpoint-agent # pwd                                                                       
/opt/pinpoint-agent
/opt/pinpoint-agent # ll                                                                       
总用量 172K
drwxr-xr-x. 2 root root  245 1月  11 21:17 boot
-rw-rw-r--. 1  500  500  255 9月   9 2020 build.info
drwxr-xr-x. 2 root root 4.0K 1月  11 21:17 lib
drwxrwxr-x. 2  500  500    6 9月   9 2020 logs
-rw-rw-r--. 1  500  500  65K 9月   9 2020 pinpoint-bootstrap-2.1.0.jar
-rw-rw-r--. 1  500  500  65K 9月   9 2020 pinpoint-bootstrap.jar
-rw-rw-r--. 1  500  500  14K 9月   9 2020 pinpoint-root.config
drwxr-xr-x. 2 root root 4.0K 1月  11 21:17 plugin
drwxrwxr-x. 4  500  500   34 9月   9 2020 profiles
drwxrwxr-x. 2  500  500   28 9月   9 2020 script
drwxr-xr-x. 2 root root   38 1月  11 21:17 tools
-rw-rw-r--. 1  500  500    5 9月   9 2020 VERSION

```

目录结构如下，修改pinpoint.config配置文件（local和release都修改）

```sh
~/pinpoint-agent-2.1.0/profiles # tree                                                        
.
├── local
│   ├── log4j2.xml
│   └── pinpoint.config
└── release
    ├── log4j2.xml
    └── pinpoint.config

```

修改pinpoint ip

```properties
profiler.transport.grpc.collector.ip=192.168.174.181
profiler.collector.ip=192.168.174.181
```

## 监控jar

- `-javaagent`指定`pinpoint-bootstrap-2.1.0.jar`路径
- `-Dpinpoint.agentId`指定agentId（全局唯一）
- `-Dpinpoint.applicationName`指定应用名称

```sh
java -javaagent:/opt/pinpoint-agent/pinpoint-bootstrap-2.1.0.jar -Dpinpoint.agentId=agentId-1  -Dpinpoint.applicationName=performance-1 -jar performance-0.1.jar
```

启动会稍微有点慢，启动完成之后在WebUI上刷新可看到应用信息
