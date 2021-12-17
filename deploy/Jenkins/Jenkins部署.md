# jenkins 部署

## 安装

可以直接安装,也可以用docker安装

```sh
# 拉取镜像
docker pull jenkins/jenkins:lts
# 运行容器
docker run -d --name jenkins -p 8081:8080 jenkins/jenkins:lts;
# 查看
docker ps | grep jenkins;
```

### 访问Jenkins

```
http://120.26.50.165:8081 //ip:端口号
```

```sh
# 进入jenkins 
docker exec -it jenkins  bash
# 查看密码
cat /var/jenkins_home/secrets/initialAdminPassword 
```

## 插件

安装推荐插件

如果部分插件无法安装通过上传的方式安装

Maven Integration

Publish Over SSH

## Global Tool Configuration

Global Tool Configuration需要配置jdk maven git 



## 添加 `SSH Server`

![image-20211217092039146](https://cruder-figure-bed.oss-cn-beijing.aliyuncs.com/markdown/2021/12/17/09-20-39-500.png)

## 添加GIT凭据

凭据` 是用来从 Git 仓库拉取代码的，打开 `凭据` -> `系统` -> `全局凭据` -> `添加凭据

## 部署服务器配置 SSH Publishers

![image-20211217092057948](https://cruder-figure-bed.oss-cn-beijing.aliyuncs.com/markdown/2021/12/17/09-20-58-251.png)

## 部署服务器 准备deploy.sh脚本

```sh
# Java环境
export JAVA_HOME PATH CLASSPATH
JAVA_HOME=/usr/java/jdk1.8.0_291
PATH=$JAVA_HOME/bin:$JAVA_HOME/jre/bin:$PATH
CLASSPATH=.:$JAVA_HOME/lib:$JAVA_HOME/jre/lib:$CLASSPATH

# 目录
DIR=/root/jenkins-in
# jar包名称
JARFILE=jenkins-demo-0.0.1-SNAPSHOT.jar
# 杀死端口占用进程
kill -9 `lsof -ti:15001`
# 运行新的应用
nohup java -jar $DIR/$JARFILE > $DIR/out.log 2>&1 &
```

