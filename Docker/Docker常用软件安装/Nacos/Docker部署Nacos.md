### Docker部署Nacos

1.拉取镜像 默认会拉取最新的版本，如果是2.0则需要注意端口映射

```shell
docker pull nacos/nacos-server
```

2.单机模式启动

```shell
#参数说明：
#MODE standalone  单机模式
docker run --env MODE=standalone --name nacos -d -p 8056:8848  -p 9056:9056 nacos/nacos-server

# nacos2.0 新开了两个端口默认端口（8848）+1000/1001, 就是9848、9849，用作gRPC与客户端、服务端做交互，所以如果引用的是2.0的客户端，server就要使用2.0的server
docker run --env MODE=standalone --name nacos -d -p 8848:8848  -p 9848:9848 -p 9849:9849 nacos/nacos-server
```

3.访问测试

```
开放8848端口或者关闭防火墙
直接访问 http://192.168.0.182:8848/nacos， 使用账号：nacos，密码：nacos 直接登录
```