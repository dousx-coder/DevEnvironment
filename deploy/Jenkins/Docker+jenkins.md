# Docker+Jenkins+Maven

## 1. 安装Jenkins

### 1.1 查找镜像

```sh
docker search jenkins
```
### 1.2 拉取镜像
```sh
docker pull jenkinsci/blueocean:latest
```
### 1.3 创建容器
```sh
docker run -d --name jenkins \
 --restart=always \
 -p 8080:8080 \
 -p 50000:50000 jenkinsci/blueocean:latest
```
### 1.4 访问Jenkins

#### 1.4.1 访问

打开浏览器输入http://ip:8080/

提示输入密码，密码路径`/var/jenkins_home/secrets/initialAdminPassword`
```sh
# 查看密码
docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword                     
```

#### 1.4.2  进入插件安装页面

![image-20220204174603494](https://cruder-figure-bed.oss-cn-beijing.aliyuncs.com/markdown/2022/02/04/05-46-03-883.png)

选择`安装推荐的插件`

![image-20220204174630267](https://cruder-figure-bed.oss-cn-beijing.aliyuncs.com/markdown/2022/02/04/05-46-30-603.png)



等待安装

![image-20220204174712608](https://cruder-figure-bed.oss-cn-beijing.aliyuncs.com/markdown/2022/02/04/05-47-12-939.png)

#### 1.4.3创建管理员用户

![image-20220204174751132](https://cruder-figure-bed.oss-cn-beijing.aliyuncs.com/markdown/2022/02/04/05-47-51-441.png)

![image-20220204174937003](https://cruder-figure-bed.oss-cn-beijing.aliyuncs.com/markdown/2022/02/04/05-49-37-399.png)

## 2. 全局工具配置



![image-20220204175038984](https://cruder-figure-bed.oss-cn-beijing.aliyuncs.com/markdown/2022/02/04/05-50-39-336.png)

![image-20220204175102618](https://cruder-figure-bed.oss-cn-beijing.aliyuncs.com/markdown/2022/02/04/05-51-03-052.png)

### 2.1 配置JDK

容器自带JDK,进入容器查看JDK路径

```sh
# 进入容器
docker exec -it -u root jenkins /bin/sh
# 查看jdk路径
echo $JAVA_HOME
# 查看JDK版本
java --version
```

![image-20220204175420816](https://cruder-figure-bed.oss-cn-beijing.aliyuncs.com/markdown/2022/02/04/05-54-21-038.png)

### 2.2 配置Maven

![image-20220204175540642](https://cruder-figure-bed.oss-cn-beijing.aliyuncs.com/markdown/2022/02/04/05-55-40-859.png)

配置完成之后 点击`保存`

### 2.3 安装插件

![image-20220204175633848](https://cruder-figure-bed.oss-cn-beijing.aliyuncs.com/markdown/2022/02/04/05-56-34-141.png)

**主要安装3个插件,搜索插件名勾选,然后点击下载**

- Maven Integration (maven插件)
- Git Parameter(git参数定义插件)
- SSH2 Easy)(远程服务器上传文件及执行脚本插件)

> [SSH2 Easy在Jenkins上的存在bug](https://issues.jenkins.io/browse/JENKINS-25258?focusedCommentId=274232&page=com.atlassian.jira.plugin.system.issuetabpanels%3Acomment-tabpanel#comment-274232)
>
> [com.jcraft.jsch:0.1.48 => com.jcraft.jsch:0.1.53](https://github.com/jenkinsci/ssh2easy-plugin/pull/14)
>
> 可以手动修改`com.jcraft.jsch:0.1.48 => com.jcraft.jsch:0.1.53`然后打包成hpi上传插件的方式安装

**安装完成之后重启Jenkins**

## 3.配置远程服务器ssh连接



![image-20220204180628752](https://cruder-figure-bed.oss-cn-beijing.aliyuncs.com/markdown/2022/02/04/06-06-28-993.png)

![image-20220204180713444](https://cruder-figure-bed.oss-cn-beijing.aliyuncs.com/markdown/2022/02/04/06-07-13-657.png)

新增组和服务器

![image-20220204180926079](https://cruder-figure-bed.oss-cn-beijing.aliyuncs.com/markdown/2022/02/04/06-09-26-466.png)

## 4.创建Maven项目

### 4.1创建Maven项目

![image-20220204181600739](https://cruder-figure-bed.oss-cn-beijing.aliyuncs.com/markdown/2022/02/04/06-16-01-090.png)

### 4.2配置git参数

![image-20220204181737294](https://cruder-figure-bed.oss-cn-beijing.aliyuncs.com/markdown/2022/02/04/06-17-37-604.png)

配置git

![image-20220204181834869](https://cruder-figure-bed.oss-cn-beijing.aliyuncs.com/markdown/2022/02/04/06-18-35-213.png)

![image-20220204181941073](https://cruder-figure-bed.oss-cn-beijing.aliyuncs.com/markdown/2022/02/04/06-19-41-400.png)

配置git远程仓库账号

![image-20220204182045322](https://cruder-figure-bed.oss-cn-beijing.aliyuncs.com/markdown/2022/02/04/06-20-45-700.png)

![image-20220204182118530](https://cruder-figure-bed.oss-cn-beijing.aliyuncs.com/markdown/2022/02/04/06-21-18-718.png)

![image-20220204182229261](https://cruder-figure-bed.oss-cn-beijing.aliyuncs.com/markdown/2022/02/04/06-22-29-615.png)

###  4.3 配置Maven打包命令

```sh
clean package -Dmaven.prod.skip=true -e
```

![image-20220204182319299](https://cruder-figure-bed.oss-cn-beijing.aliyuncs.com/markdown/2022/02/04/06-23-19-531.png)

### 4.5 配置jar包上传指令

![image-20220204182442889](https://cruder-figure-bed.oss-cn-beijing.aliyuncs.com/markdown/2022/02/04/06-24-43-131.png)

上传Jar包配置

![image-20220204183017875](https://cruder-figure-bed.oss-cn-beijing.aliyuncs.com/markdown/2022/02/04/06-30-18-210.png)

**注意,Jenkins打包好的文件在`/var/jenkins_home/workspace/`目录下,进入容器可以查看**

**`${JOB_NAME} `是Jenkins的预设参数,值为项目名**

![image-20220204183137343](https://cruder-figure-bed.oss-cn-beijing.aliyuncs.com/markdown/2022/02/04/06-31-37-675.png)

### 4.6 执行远程命令

![image-20220204215859993](https://cruder-figure-bed.oss-cn-beijing.aliyuncs.com/markdown/2022/02/04/09-59-00-228.png)

**app.sh**
```sh
#!/bin/bash


PROJECT_NAME=jenkins-mvn
# 日志前缀: jenkins-mvn-2022-02-02.log
LOG_PREFIX=/usr/local/program/${PROJECT_NAME}/logs/${PROJECT_NAME}/${PROJECT_NAME}-
# jar包路径
JAR_PATH=/usr/local/program/${PROJECT_NAME}/${PROJECT_NAME}.jar
# spring boot配置
ACTIVE=dev

usage() {
  echo "Usage: sh ShellName.sh [start|stop|restart|status]"
  exit 1
}

file_is_exist() {
  if [ -f "${JAR_PATH}" ]; then
    return 1
  else
    echo "${JAR_PATH} is not exist"
    exit 0
  fi
}
# shellcheck disable=SC2120
is_run() {
  file_is_exist
  #echo "ps -ef|grep ${JAR_PATH}|grep -v grep|awk '{print $2}' "
  pid=$(ps -ef | grep ${JAR_PATH} | grep -v grep | awk '{print $2}')
  if [ -z "${pid}" ]; then
    return 1
  else
    return 0
  fi
}

start() {
  is_run
  if [ $? -eq "0" ]; then
    echo "${JAR_PATH} is already running. pid = ${pid} ."
  else
    # No default log is generated. Use logback or log4j2
    echo " nohup java -Xms512m -Xmx1024m -XX:+HeapDumpOnOutOfMemoryError \ "
    echo "-XX:HeapDumpPath=./ -jar  \  "
    echo "-Dspring.profiles.active=${ACTIVE} \ "
    echo "${JAR_PATH} >/dev/null 2>&1 & "

    nohup java -Xms512m -Xmx1024m -XX:+HeapDumpOnOutOfMemoryError \
      -XX:HeapDumpPath=./  -jar \
      -Dspring.profiles.active=${ACTIVE} \
      ${JAR_PATH} >/dev/null 2>&1 &
    now_date=$(date +%Y-%m-%d)
    echo "If you need to view the log, please execute ' tail -20f ${LOG_PREFIX}${now_date}.log '"
#    sleep 3s
#    echo "tail -20f ${LOG_PREFIX}${now_date}.log"
#    tail -20f ${LOG_PREFIX}${now_date}.log
  fi
}

stop() {
  is_run
  if [ $? -eq "0" ]; then
    echo "kill -9 ${pid}"
    kill -9 $pid
    echo "${pid} Stopping."
  fi
  echo "${JAR_PATH} is NOT running."
}
parameter() {
  echo "jinfo -flags ${pid}"
  jinfo -flags ${pid}
}
status() {
  is_run
  if [ $? -eq "0" ]; then
    echo "${JAR_PATH} is running. Pid is ${pid}"
    parameter
  else
    echo "${JAR_PATH} is NOT running."
  fi
}
restart() {
  stop
  start
}

case "$1" in
"start")
  start
  ;;
"stop")
  stop
  ;;
"status")
  status
  ;;
"restart")
  restart
  ;;
*)
  usage
  ;;
esac

```

### 4.7 构建测试

![image-20220204185524094](https://cruder-figure-bed.oss-cn-beijing.aliyuncs.com/markdown/2022/02/04/06-55-24-382.png)

控制台查看日志

![image-20220204185629815](https://cruder-figure-bed.oss-cn-beijing.aliyuncs.com/markdown/2022/02/04/06-56-30-057.png)



**tips**

执行脚本远程服务器命令行，拓展一下，可以获取当前项目版本号，然后打个tag到git仓库，以及发布成功之后钉钉机器人推送等。

