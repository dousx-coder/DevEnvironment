### Docker部署Nacos

1.拉取镜像

```shell
docker pull nacos/nacos-server
```

2.单机模式启动

```shell
#参数说明：
#MODE standalone  单机模式
docker run --env MODE=standalone --name nacos -d -p 8848:8848 nacos/nacos-server
```

3.访问测试

```
开放8848端口或者关闭防火墙
直接访问 http://192.168.0.182:8848/nacos， 使用账号：nacos，密码：nacos 直接登录
```