### Docker部署RabbitMQ
拉取镜像，并指定版本，该版本包含了web控制页面

```shell
docker pull rabbitmq:3.7.19-management
```
创建容器

```shell
docker run -d \
--restart=always \
--hostname my-rabbit \
--name rabbitmq \
-p 5672:5672 \
-p 15672:15672 \
rabbitmq:3.7.19-management
```
测试

```shell
打开浏览器输入http://ip:15672/  
默认username和password均为guest
```
