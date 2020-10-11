## 一、Docker安装

1、yum 包更新到最新 

```
yum update
```

2、安装需要的软件包， yum-util 提供yum-config-manager功能，另外两个是devicemapper驱动依赖的

```
yum install -y yum-utils device-mapper-persistent-data lvm2
```

3、 设置yum源

```
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
```

4、 安装docker

```
yum install -y docker-ce
```

5.查看docker版本，验证是否验证成功

```
docker -v
```

6.设置自启动等

```shell
# 启动docker服务
systemctl start docker
# 设置开机自启docker
systemctl enable docker
# 重启docker命令
systemctl restart docker
# 停止docker服务
systemctl stop docker
#安装完成后打开阿里云设置镜像加速
```



## 二、Docker 应用部署

### 1、部署MySQL

1. 搜索mysql镜像

```shell
docker search mysql
```

2. 拉取mysql镜像

```shell
docker pull mysql:5.7
```

3. 创建映射目录

```shell
# 在/root目录下创建mysql目录用于存储mysql数据信息
mkdir -p /usr/local/docker/mysql57
# 切换目录  $PWD使用的是当前目录
cd /usr/local/docker/mysql57
```
4.创建容器，设置端口映射、目录映射
```shell
docker run -id \
--restart=always \
-p 3306:3306 \
--name=mysql57 \
-v $PWD/conf:/etc/mysql/conf.d \
-v $PWD/logs:/logs \
-v $PWD/data:/var/lib/mysql \
-e MYSQL_ROOT_PASSWORD=root \
mysql:5.7 \
--lower_case_table_names=1
```
5.进入容器，操作mysql

```shell
docker exec -it mysql57 /bin/bash
```

6.说明

```
-p 3307:3306：将容器的 3306 端口映射到宿主机的 3306 端口
-v $PWD/conf:/etc/mysql/conf.d：将主机当前目录下的 conf/my.cnf 挂载到容器的 /etc/mysql/my.cnf
配置目录
-v $PWD/logs:/logs：将主机当前目录下的 logs 目录挂载到容器的 /logs。日志目录
-v $PWD/data:/var/lib/mysql ：将主机当前目录下的data目录挂载到容器的 /var/lib/mysql 。数据目录
-e MYSQL_ROOT_PASSWORD=123456：初始化 root 用户的密码
--lower_case_table_names=1 忽略sql大小写
在运行docker容器时可以加如下参数来保证每次docker服务重启后容器也自动重启：--restart=always
如果已经启动了则可以使用如下命令 docker update --restart=always <CONTAINER ID>
```



##### 如果是部署mysql8.0

```shell
docker pull mysql:8.0
```

```shell
docker run -id \
--restart=always \
-p 3306:3306 \
--name=mysql80 \
-v $PWD/conf:/etc/mysql/conf.d \
-v $PWD/logs:/logs \
-v $PWD/data:/var/lib/mysql \
-e MYSQL_ROOT_PASSWORD=root \
mysql:8.0 \
--lower_case_table_names=1
```

###### 更新密码规则

```shell
docker exec -it mysql80 /bin/bash
mysql -uroot -p
use mysql;
ALTER USER 'root'@'%' IDENTIFIED WITH mysql_native_password BY 'root';
FLUSH PRIVILEGES; 
```



### 2、部署Redis

1.搜索redis镜像

```shell
docker search redis
```

2.拉取redis镜像

```shell
docker pull redis:latest
```

3.配置redis.conf

```shell
将redis.conf上传到改目录下
# bind 127.0.0.1
protected-mode no
daemonize no
requirepass 密码

```

4.创建映射目录

```
mkdir  -p /usr/local/docker/redis
```

 创建容器，设置端口映射

```shell
docker run -p 6379:6379 \
--restart=always \
--name redis \
-v /usr/local/docker/redis/redis.conf:/etc/redis/redis.conf  \
-v /usr/local/docker/redis/data:/data \
-d redis redis-server /etc/redis/redis.conf \
--appendonly yes
```

5.使用外部机器连接redis

```shell
# -a后面为reids密码
redis-cli -h 192.168.0.181 -p 6379 -a redis
```



#### 3、部署RabbitMQ

1. 拉取镜像，并指定版本，该版本包含了web控制页面

```shell
docker pull rabbitmq:3-management
```

2.创建容器

```shell
docker run -d \
--restart=always \
--hostname my-rabbit \
--name rabbit \
-p 5672:5672 \
-p 15672:15672 \
rabbitmq:3-management
```

3.测试

```shell
打开浏览器输入http://192.168.0.182:15672/  

默认username和password均为guest
```



### 4、部署PostgreSQL

1.拉去镜像

```shell
docker pull postgres:10
```
2.目录映射

```
mkdir -p /usr/local/docker/postgresql10
```

3.创建容器

```
docker run -d  \
--name postgres \
--restart=always \
-e POSTGRES_PASSWORD=root \
-v  /usr/local/docker/postgresql10:/var/lib/postgresql/data \
-p 5432:5432 \
postgres:10
```

4.说明

```
run，创建并运行一个容器；
--name，指定创建的容器的名字；
-e POSTGRES_PASSWORD=password，设置环境变量，指定数据库的登录口令为password；
-p 5432:5432，端口映射将容器的5432端口映射到外部机器的5432端口；
-d 后台运行
postgres:10，指定使用postgres:10作为镜像
需要将刚上个步骤创建的卷 /usr/local/docker/postgresql10 挂载到容器的 /var/lib/postgresql/data 目录
postgres用户名postgres 密码为password
```



### 5、部署nginx

 1.拉去镜像

```shell
docker pull nginx
```

2.创建容器

```shell
docker run --name nginx -p 9999:80 -d nginx
```

3.浏览器打开访问 测试

```shell
http://192.168.0.182:9999/
```

4.创建挂载目录

```shell
mkdir -p /usr/local/docker/nginx/html   /usr/local/docker/nginx/logs  /usr/local/docker/nginx/conf 
```

5.复制conf文件,75798dd5878d 为容器id

```shell
docker cp 4a295dc1708f:/etc/nginx/nginx.conf /usr/local/docker/nginx/conf
docker cp 4a295dc1708f:/usr/share/nginx/html/50x.html /usr/local/docker/nginx/html
docker cp 4a295dc1708f:/usr/share/nginx/html/index.html /usr/local/docker/nginx/html
```

 6.删除之前的容器

```shell
docker stop 4a295dc1708f
docker rm 4a295dc1708f
```

7.切换目录

```shell
cd /usr/local/docker/
```

8.创建容器

```shell
docker run -d  \
-p 80:80  \
--name nginx  \
--restart=always \
-v $PWD/nginx/html:/usr/share/nginx/html  \
-v $PWD/nginx/conf/nginx.conf:/etc/nginx/nginx.conf  \
-v $PWD/nginx/logs:/var/log/nginx nginx
```

9.说明

```
先创建一个nginx映射到9999端口是为了从容器中拿到 nginx的配置文件
```

### 6、部署Nacos

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

### 7、docker内部安装vim

```
apt-get update

apt-get install vim
```

