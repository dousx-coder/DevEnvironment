## Docker MySQL主从配置

#### 1.安装MySQL

```shell
# 主
mkdir -p /opt/dockerSoftware/mysql801

docker run -id \
--restart=always \
-p 3801:3306 \
--name=mysql801 \
-v /opt/dockerSoftware/mysql801/conf:/etc/mysql/conf.d \
-v /opt/dockerSoftware/mysql801/logs:/logs \
-v /opt/dockerSoftware/mysql801/data:/var/lib/mysql \
-e MYSQL_ROOT_PASSWORD=root \
mysql:8.0 \
--lower_case_table_names=1

# 从
mkdir -p /opt/dockerSoftware/mysql802

docker run -id \
--restart=always \
-p 3802:3306 \
--name=mysql802 \
-v /opt/dockerSoftware/mysql802/conf:/etc/mysql/conf.d \
-v /opt/dockerSoftware/mysql802/logs:/logs \
-v /opt/dockerSoftware/mysql802/data:/var/lib/mysql \
-e MYSQL_ROOT_PASSWORD=root \
mysql:8.0 \
--lower_case_table_names=1

```

```shell
# 进入容器内部 修改密码规则
docker exec -it mysql801 /bin/bash
mysql -uroot -p
use mysql;
ALTER USER 'root'@'%' IDENTIFIED WITH mysql_native_password BY 'root';
FLUSH PRIVILEGES; 

# 进入容器内部 修改密码规则
docker exec -it mysql802 /bin/bash
mysql -uroot -p
use mysql;
ALTER USER 'root'@'%' IDENTIFIED WITH mysql_native_password BY 'root';
FLUSH PRIVILEGES; 
```

```mysql
# 在主数据库上创建数据同步用户，授予用户 slave REPLICATION SLAVE权限和REPLICATION CLIENT权限，用于在主从库之间同步数据。
create user 'slave'@'%' identified by '123456';
flush privileges;
grant REPLICATION SLAVE, REPLICATION CLIENT on *.* to 'slave'@'%' with grant option;
flush privileges;
# 如果是MySQL8 则还需修改密码规则
ALTER USER 'slave'@'%' IDENTIFIED WITH mysql_native_password BY '123456';
flush privileges;
```



#### 2.my.cnf配置

```shell
## 主库 /etc/mysql/my.cnf 添加下面配置 
## 同一局域网内注意要唯一
server-id=101  
## 开启二进制日志功能，可以随便取（关键）
log-bin=master-bin
# 二级制日志格式，有三种 row，statement，mixed
binlog-format=ROW     
## binlog-do-db=数据库名  //同步的数据库名称,如果不配置，表示同步所有的库
```

```shell
## 从库 /etc/mysql/my.cnf 添加下面配置
## 设置server_id,注意要唯一
server-id=102  
## 开启二进制日志功能，以备Slave作为其它Slave的Master时使用
log-bin=mysql-slave-bin   
## relay_log配置中继日志
relay_log=mysql-relay-bin  
read_only=1  ## 设置为只读,该项如果不设置，表示slave可读可写
```

```shell
# 可以先从容器中拷贝将my.cnf拷贝出来 在宿主机编辑，然后再从宿主机将编辑好的my.cnf拷贝到容器内部 这样容器内部无需下载vim

# 容器内的my.cnf拷贝到宿主机
docker cp mysql801:/etc/mysql/my.cnf /opt/dockerSoftware/my.cnf

# 宿主机的my.cnf拷贝到容器内
docker cp /opt/dockerSoftware/my.cnf mysql802:/etc/mysql/my.cnf
```

#### 3.开启主从

```shell
# 进入容器内部  主库
docker exec -it mysql801 /bin/bash
```

```mysql
# 主库查看File 以及File 字段的值 以及Position的值
show master status;
```

```shell
# 进入容器内部 从库
docker exec -it mysql802 /bin/bash
```

```mysql
change master to master_host='172.17.0.2', master_user='slave', master_password='123456', master_port=3306, master_log_file='master-bin.000002', master_log_pos=156, master_connect_retry=30;
# 命令说明：
# master_host ：主库，指的是容器的独立ip,
# 容器的独立ip可以通过docker inspect --format='{{.NetworkSettings.IPAddress}}' 容器名称  进行查询
# master_port：Master的端口号，指的是容器的端口号
# master_user：用于数据同步的用户
# master_password：用于同步的用户的密码
# master_log_file：指定 Slave 从哪个日志文件开始复制数据，即上文中提到的 File 字段的值
# master_log_pos：从哪个 Position 开始读，即上文中提到的 Position 字段的值
# master_connect_retry：如果连接失败，重试的时间间隔，单位是秒，默认是60秒
```

#### 4.查看是否成功

```mysql
# 从库 执行
start slave;
# 从库 查看是否开启同步状态
show slave status \G;

# 均显示yes则开启成功
# Slave_IO_Running: Yes
# Slave_SQL_Running: Yes
```

#### 5.从库 创建只读用户 方便客户端读取

```mysql
# 从库 创建只读用户
create user 'onlyReader'@'%' identified by '123456';
flush privileges;
# 授权 select 可换成all privileges,update,insert,delete,drop,create等操作
grant select on *.* to 'onlyReader'@'%' with grant option;
flush privileges;
# mysql8 修改密码规则
ALTER USER 'onlyReader'@'%' IDENTIFIED WITH mysql_native_password BY '123456';
flush privileges;
```





