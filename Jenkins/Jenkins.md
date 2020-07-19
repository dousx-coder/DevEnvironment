#Jenkins安装步骤

### 安装Jenkins（war方式）

```shell
mkdir -p /opt/jenkins
# 将jenkins.war传到该目录
cd /opt/jenkins

```
>vim jenkins.sh 编写jenkins.sh，内容如下

```shell
#!/bin/bash
# 配置要启动关闭的脚本名
process_name="jenkins.war"
# 修改端口和JENKINS_HOME 当前是当前目录
http_port=9191
export JENKINS_HOME=./home
# 添加启动命令
function start(){
    echo "start..."
 
    nohup java -Dhudson.model.DownloadService.noSignatureCheck=true -jar $process_name --httpPort=$http_port 2>&1 &
 
    echo "start successful"
    return 0
}
 
# 添加停止命令
function stop(){
    echo "stop..."
 
    ps aux |grep $process_name |grep -v grep |awk '{print "kill -9 " $2}'|sh
 
    echo "stop successful"
    return 0
}
 
case $1 in
"start")
    start
    ;;
"stop")
    stop
    ;;
"restart")
    stop && start
    ;;
*)
    echo "请输入: start, stop, restart"
    ;;
esac
```

```shell
chmod +x jenkins.sh 
```

```shell
./jenkins.sh start # 启动
```


```shell
*************************************************************
*************************************************************
*************************************************************

Jenkins initial setup is required. An admin user has been created and a password generated.
Please use the following password to proceed to installation:

da40f71f5ee640f681cefbb039cabf35

This may also be found at: /opt/jenkins/home/secrets/initialAdminPassword

*************************************************************
*************************************************************
*************************************************************
```

>da40f71f5ee640f681cefbb039cabf35 为初始化管理员密码



4

```
打开浏览器输入http://192.168.0.182:9191/
/opt/jenkins/home/secrets/initialAdminPassword
```

![1595134699123](C:\Users\Dsx\AppData\Roaming\Typora\typora-user-images\1595134699123.png)

```
将密码粘贴进去，到自定义插件安装的时候 不要直接下一步 此时需要把Jenkins停止，然后配置国内镜像，必须是先输入密码在配置国内镜像
```

![1595134799797](C:\Users\Dsx\AppData\Roaming\Typora\typora-user-images\1595134799797.png)

```shell
./jenkins.sh stop
cd /opt/jenkins/home/updates/  #进入更新配置位置
```

```shell
# 配置国内镜像
sudo sed -i 's/http:\/\/updates.jenkins-ci.org\/download/https:\/\/mirrors.tuna.tsinghua.edu.cn\/jenkins/g' default.json && sed -i 's/http:\/\/www.google.com/https:\/\/www.baidu.com/g' default.json
```

>重新启动Jenkins

```shell
cat /opt/jenkins/home/secrets/initialAdminPassword #查看密码，并输入，接下来选择安装推荐插件
```

![1595135193280](C:\Users\Dsx\AppData\Roaming\Typora\typora-user-images\1595135193280.png)

![1595135207248](C:\Users\Dsx\AppData\Roaming\Typora\typora-user-images\1595135207248.png)

![1595135266805](C:\Users\Dsx\AppData\Roaming\Typora\typora-user-images\1595135266805.png)

```
插件安装完成后创建新用户
```

![1595135307063](C:\Users\Dsx\AppData\Roaming\Typora\typora-user-images\1595135307063.png)

### 配置Jenkins全局配置需要确保以下交给条件满足

```shell
[root@localhost ~]# git --version
git version 1.8.3.1
[root@localhost ~]# echo $JAVA_HOME
/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.252.b09-2.el7_8.x86_64
[root@localhost ~]# echo $MAVEN_HOME
/opt/apache-maven-3.6.3
[root@localhost ~]# docker -v
Docker version 19.03.12, build 48a66213fe
```

![1595135703733](C:\Users\Dsx\AppData\Roaming\Typora\typora-user-images\1595135703733.png)

![1595135863953](C:\Users\Dsx\AppData\Roaming\Typora\typora-user-images\1595135863953.png)

![1595135877014](C:\Users\Dsx\AppData\Roaming\Typora\typora-user-images\1595135877014.png)