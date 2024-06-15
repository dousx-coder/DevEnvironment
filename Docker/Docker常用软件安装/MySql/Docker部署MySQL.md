# Docker 部署 MySQL

## 1.部署 Mysql5.7

1. 搜索 mysql 镜像

```shell
docker search mysql
```

2. 拉取 mysql 镜像

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

5 .进入容器，操作 mysql

```shell
docker exec -it mysql57 /bin/bash
```

## 2.部署 Mysql8.4

> 8.4 不需要修改密码规则？？？

1. 拉取镜像

```shell
docker pull mysql:8.4-oracle
```

2. 创建挂载目录

```shell
mkdir -p /usr/local/docker/mysql-8.4 && cd /usr/local/docker/mysql-8.4
```

3. 创建容器

```shell
docker run -id \
--restart=always \
-p 3306:3306 \
--name=mysql-8.4 \
-v $PWD/conf:/etc/mysql/conf.d \
-v $PWD/logs:/logs \
-v $PWD/data:/var/lib/mysql \
-e MYSQL_ROOT_PASSWORD=root \
mysql:8.4-oracle \
--lower_case_table_names=1
```

5. MySql Clinet 中文乱码

```shell
vim /etc/my.cnf
```

添加以下内容

```
[client]

default-character-set=utf8
```

## 3.Windows 下部署以及挂载目录

> - 挂载目录需要有权限
> - 挂载目录中不能包含空格和中文

### 3.1 mysql 5.7

```powershell
docker run -id -p 3305:3306 --name=mysql-5.7 -v C:/Users/dousx/.data/.docker/mysql-5.7/conf:/etc/mysql/conf.d -v C:/Users/dousx/.data/.docker/mysql-5.7/logs:/logs -v C:/Users/dousx/.data/.docker/mysql-5.7/data:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=root -e TZ=Asia/Shanghai mysql:5.7 --lower_case_table_names=1
```

### 3.2 mysql 8.4

```powershell
docker run -id --restart=always -p 3306:3306 --name=mysql-8.4 -v C:/Users/dousx/.data/.docker/mysql-8.4/conf:/etc/mysql/conf.d -v C:/Users/dousx/.data/.docker/mysql-8.4/logs:/logs -v C:/Users/dousx/.data/.docker/mysql-8.4/data:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=root -e TZ=Asia/Shanghai mysql:8.4-oracle --lower_case_table_names=1
```

## 4.命令说明

- -p 3307:3306：将容器的 3306 端口映射到宿主机的 3306 端口

- -v $PWD/conf:/etc/mysql/conf.d：将主机当前目录下的 `conf/my.cnf` 挂载到容器的 `/etc/mysql/my.cnf`
  配置目录

- -v $PWD/logs:/logs：将主机当前目录下的 logs 目录挂载到容器的 /logs。日志目录

- -v $PWD/data:/var/lib/mysql ：将主机当前目录下的 data 目录挂载到容器的 /var/lib/mysql 。数据目录

- -e MYSQL_ROOT_PASSWORD=123456：初始化 root 用户的密码
- -e TZ=Asia/Shanghai 时区

- --lower_case_table_names=1 忽略 sql 大小写

- 在运行 docker 容器时可以加如下参数来保证每次 docker 服务重启后容器也自动重启：`--restart=always`

- 如果已经启动了则可以使用如下命令 docker update --restart=always `<CONTAINER ID>`
