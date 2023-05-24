# Docker部署RabbitMQ

1. 拉取镜像，并指定版本，该版本包含了web控制页面

```shell
docker pull rabbitmq:3.11.9-management-alpine
```
2. 创建容器
> Apple M系列芯片用3.11.9连接报错
```shell
docker run -d \
--restart=always \
--name rabbitmq \
-p 5672:5672 \
-p 15672:15672 \
rabbitmq:3.12-rc-management-alpine
```
3. 测试

打开浏览器输入http://ip:15672/ 

username: `guest` ,password: `guest`

**edge的Admin界面有些组件没有展示 用chrome就没有问题 很奇怪?**


**Windows创建容器**

```powershell
docker run -d --restart=always --name rabbitmq -p 5672:5672 -p 15672:15672 rabbitmq:3.11.9连接报错-management-alpine
```