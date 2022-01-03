

# Docker部署jenkins

## 1.拉取

> https://hub.docker.com/_/jenkins?tab=tags
>
> jenkins/jenkins:2.222.3-centos   镜像已经汉化

```shell
~ # docker pull jenkins/jenkins:2.222.3-centos                                                 
2.222.3-centos: Pulling from jenkins/jenkins
8a29a15cefae: Pull complete
1bd84e91a97b: Pull complete
7c25510bcedf: Pull complete
bd3215ccdc72: Pull complete
c1494e29185b: Pull complete
2e6752a207fe: Pull complete
0cf87baaf50f: Pull complete
0857052f3905: Pull complete
957333a832d4: Pull complete
7b91f80bc952: Pull complete
1974a7024a87: Pull complete
d87ed61b6d16: Pull complete
a995317d9097: Pull complete
Digest: sha256:ba505d077133b3beec3c14efec24eec28a410fc923945d45950b0d544e73b946
Status: Downloaded newer image for jenkins/jenkins:2.222.3-centos
docker.io/jenkins/jenkins:2.222.3-centos                                                      
```
## 2.创建本地数据卷

> 需要修改下目录权限，因为当映射本地数据卷时，`/usr/local/docker/jenkins/`目录的拥有者为`root`用户，而容器中`jenkins`用户的 uid 为 `1000`。
```sh
~ # mkdir -p /usr/local/docker/jenkins
```

```sh
~ # chown -R 1000:1000 /usr/local/docker/jenkins/
```
## 3.创建容器

```shell
docker run -id \
--name jenkins \
--restart=always \
-p 8040:8080 \
-p 50000:50000  \
-v /usr/local/docker/jenkins:/var/jenkins_home \
jenkins/jenkins:2.222.3-centos      
```
###  说明

`-id` 标识是让 docker 容器在后台运行
`--name` 定义一个容器的名字，如果没有指定，那么会自动生成一个随机数字符串当做UUID
` --restart=always`随docker自启动
`-p 8040:8080` 端口映射，我本地的`8080`被占用了，所以随便映射了一个`8040`
`-p 50000:50000` 端口映射
`-v /usr/local/docker/jenkins:/var/jenkins_home` 绑定一个数据卷，`/usr/local/docker/jenkins`是刚才创建的本地数据卷
## 4.配置插件地址

```sh
docker exec -it --user root jenkins /bin/bash
find / -name default.json
/var/lib/jenkins/updates/default.json
```
### 替换 `default.json` 中的内容

将 `updates.jenkins-ci.org/download` 替换为 `mirrors.tuna.tsinghua.edu.cn/jenkins`，
将 `www.google.com` 替换为 `www.baidu.com`

```sh
sed -i 's/www.google.com/www.baidu.com/g' default.json
sed -i 's/updates.jenkins-ci.org\/download/mirrors.tuna.tsinghua.edu.cn\/jenkins/g' default.json
```

重启`jenkins`

```sh
~ # docker restart jenkins
```
## 5.访问

```
http://192.168.174.201:8040/
```

![image-20211230125657253](https://cruder-figure-bed.oss-cn-beijing.aliyuncs.com/markdown/2021/12/30/12-56-57-524.png)

### 输入管理员密码

这里要求输入初始的管理员密码，根据提示密码在`/var/jenkins_home/secrets/initialAdminPassword`这个文件中，注意这个路径是 Docker 容器中的，所以我们通过如下命令获取一下

```sh
~ #  docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword               
4acfaa7575d2460d96a4529e488734d5
```
此时会提示安装插件，需要先配置插件地址
![image-20211230130547949](https://cruder-figure-bed.oss-cn-beijing.aliyuncs.com/markdown/2021/12/30/01-05-48-209.png)





