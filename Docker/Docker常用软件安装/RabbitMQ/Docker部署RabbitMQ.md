# Docker部署RabbitMQ

1. 拉取镜像，并指定版本，该版本包含了web控制页面

```shell
docker pull rabbitmq:management
```
2. 创建容器

```shell
docker run -d \
--restart=always \
--hostname my-rabbit \
--name rabbitmq \
-p 5672:5672 \
-p 15672:15672 \
rabbitmq:management
```
3. 测试

打开浏览器输入http://ip:15672/ 
username: `guest` ,password: `guest`

**Windows创建容器**

```powershell
docker run -d --restart=always --hostname my-rabbit --name rabbitmq -p 5672:5672 -p 15672:15672 rabbitmq:management
```