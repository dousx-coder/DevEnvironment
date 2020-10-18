### Docker 打包

>将可执行jar包和Dockerfile放在同一目录

###Dockerfile内容如下

>FROM java:8
>
>\# 作者
>
>MAINTAINER dousx <dsx@gmail.com>
>
>
>
>\# VOLUME 指定了临时文件目录为/tmp。
>
>\# 其效果是在主机 /var/lib/docker 目录下创建了一个临时文件，并链接到容器的/tmp
>
>VOLUME /tmp 
>
>
>
>\# 将jar包添加到容器中并更名为app.jar
>
>ADD app.jar app.jar 
>
>
>
>\# 运行jar包
>
>RUN bash -c 'touch /app.jar'
>
>
>
>ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar"]

### 执行命令

```shell
# 其中app是镜像名称  字母貌似要全小写 
# 切换到jar包和Dockerfile所在目录执行
docker build -t app:0.1 .
```

### 创建容器

```shell
docker run -d -p 8899:8899 --name=app app:0.1
```

