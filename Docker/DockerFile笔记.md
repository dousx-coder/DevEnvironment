# DockerFile

## Docker编写

>高版本挂在数据卷 需要指定绝对路径，例如:/v1

```dockerfile
FROM centos

VOLUME ["/v1","/v2"]

CMD echo "----end ---"
CMD /bin/bash
```

>Volume可以将容器以及容器产生的新数据分离开来，这样使用docker rm 容器删除容器时，不会影响相关数据。

![image-20210717151906907](D:\DevEnvironment\Docker\DockerFile笔记.assets\image-20210717151906907.png)

```shell
# 查看容器信息 其中Mounts为挂载卷信息,source为宿主机目录
docker inspect 469442d13597 
```

![image-20210717151447449](D:\DevEnvironment\Docker\DockerFile笔记.assets\image-20210717151447449.png)



## 构建

```dockerfile
FROM jenkins/jenkins:lts

MAINTAINER  dousx<dsx@dousx.com>

# 添加maven  并解压到/usr/local下 apache-maven-3.6.3-bin.tar.gz如果不使用全路径,则需要压缩包要放当前目录下
ADD apache-maven-3.6.3-bin.tar.gz /usr/local


ENV MYPATH /usr/local
WORKDIR $MYPATH
# 配置maven环境变量
ENV MAVEN_HOME /usr/local/apache-maven-3.6.3
ENV PATH $PATH:$MAVEN_HOME/bin
```

> 构建

```shell
# 文件名 命名为 Dockerfile 切换到当前目录下执行 或者用 -f指定 Dockerfile文件路径
docker build -t doushaoxun/jenkins:0.1 .
```

> 推送到DockerHub

```shell
# / 前面需要是个人账号
docker push doushaoxun/jenkins:0.1
```

![image-20210718101440606](D:\DevEnvironment\Docker\DockerFile笔记.assets\image-20210718101440606.png)
