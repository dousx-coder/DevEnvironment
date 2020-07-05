### Docker部署jar

1.上传jar包到Linux(打包之前修改相应配置文件)

2.安装所需的环境，例如需要redis的话，在docker里安装redis

3.在jar包所在目录下，编写Dockerfile

```shell
vim Dockerfile
```

Dockerfile内容

```dockerfile
FROM java:8
# 端口号 和配置中保持一致
# EXPOSE 8810
# Spring Boot 使用的内嵌 Tomcat 容器默认使用/tmp作为工作目录
VOLUME /tmp
  
ENV TZ=Asia/Shanghai
RUN ln -sf /usr/share/zoneinfo/{TZ} /etc/localtime && echo "{TZ}" > /etc/timezone
#  给jar起别名
ADD demo-docker-0.0.1-SNAPSHOT.jar  /app.jar
RUN bash -c 'touch /app.jar'
ENTRYPOINT ["java","-jar","/app.jar"]
```

4.构建镜像

```shell
# 在Dockerfile所在文件目录下执行 demodocker:v1为镜像名称以及版本号
docker build -t demodockerimage:v1 . 
#查看镜像
docker images
```

5.创建容器并且启动

```shell
docker run -d \
-p 8810:8810 \   
--name demoApp \
--link redis:ConfigureRedis \
demodockerimage:v1
# --link redis:ConfigureRedis  redis表示docker容器的名字 ConfigureRedis表示配置文件中redis的地址(spring.redis.host=ConfigureRedis)

```

6.查看日志

```shell
# 查看日志
docker logs -f 容器name或者容器id
```
