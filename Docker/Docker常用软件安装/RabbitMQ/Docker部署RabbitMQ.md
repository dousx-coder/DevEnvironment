# Docker 部署 RabbitMQ

[docker hub rabbitmq](https://hub.docker.com/_/rabbitmq/tags)

1. 拉取镜像，并指定版本，该版本包含了 web 控制页面

```shell
docker pull rabbitmq:rabbitmq:3.12-rc-management-alpine
```

2. 创建容器
   > Apple M 系列芯片用 3.11.9 连接报错

```shell
docker run -d \
--restart=always \
--name rabbitmq \
-p 5672:5672 \
-p 15672:15672 \
rabbitmq:3.12-rc-management-alpine
```

3. 测试

打开浏览器输入 http://ip:15672/

username: `guest` ,password: `guest`

**edge 的 Admin 界面有些组件没有展示 用 chrome 就没有问题 很奇怪?**

**Windows 创建容器**

```powershell
docker run -d --restart=always --name rabbitmq -p 5672:5672 -p 15672:15672 rabbitmq:3.12-rc-management-alpine
```
