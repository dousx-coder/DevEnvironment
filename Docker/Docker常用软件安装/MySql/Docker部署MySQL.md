# Docker部署MySQL

## 1.部署Mysql5.7

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
4. 创建容器，设置端口映射、目录映射

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
5 .进入容器，操作mysql

```shell
docker exec -it mysql57 /bin/bash
```

## 2.部署Mysql8.0

1. 拉取镜像

```shell
docker pull mysql:8.0
```
2. 创建挂载目录

```shell
mkdir -p /usr/local/docker/mysql80 && cd /usr/local/docker/mysql80
```

3. 创建容器

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

4. MySql8.0需要 更新密码规则

```shell
docker exec -it mysql80 /bin/bash
mysql -uroot -p
use mysql;
ALTER USER 'root'@'%' IDENTIFIED WITH mysql_native_password BY 'root';

FLUSH PRIVILEGES; 
exit;
```

5. MySql Clinet中文乱码
```shell
vim /etc/mysql/my.cnf
```
添加以下内容
```
[client]

default-character-set=utf8
```

## 3.Windows下部署以及挂载目录

> - MySql8.0需要更新密码规则
> - 挂载目录需要有权限
> - 挂载目录中不能包含空格和中文

```powershell
docker run -id --restart=always -p 3306:3306 --name=mysql80 -v C:/Users/dousx/.data/.docker/mysql/conf:/etc/mysql/conf.d -v C:/Users/dousx/.data/.docker/mysql/logs:/logs -v C:/Users/dousx/.data/.docker/mysql/data:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=root -e TZ=Asia/Shanghai mysql:8.0 --lower_case_table_names=1 
```
## 4.命令说明

- -p 3307:3306：将容器的 3306 端口映射到宿主机的 3306 端口

- -v $PWD/conf:/etc/mysql/conf.d：将主机当前目录下的 `conf/my.cnf` 挂载到容器的 `/etc/mysql/my.cnf`
  配置目录

- -v $PWD/logs:/logs：将主机当前目录下的 logs 目录挂载到容器的 /logs。日志目录

- -v $PWD/data:/var/lib/mysql ：将主机当前目录下的data目录挂载到容器的 /var/lib/mysql 。数据目录

- -e MYSQL_ROOT_PASSWORD=123456：初始化 root 用户的密码
- -e TZ=Asia/Shanghai 时区

- --lower_case_table_names=1 忽略sql大小写

- 在运行docker容器时可以加如下参数来保证每次docker服务重启后容器也自动重启：`--restart=always`

- 如果已经启动了则可以使用如下命令 docker update --restart=always `<CONTAINER ID>`