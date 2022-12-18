# Docker部署Redis

## 1. 搜索redis镜像

```shell
docker search redis
```

## 2. 拉取redis镜像

```shell
docker pull redis:latest
```

## 3. 创建映射目录

```sh
mkdir  -p /usr/local/docker/redis
```
## 4. 配置redis.conf（也可以直接拿同目录下配置使用）

```shell
将redis.conf上传到该目录(/usr/local/docker/redis/)下
# bind 127.0.0.1
protected-mode no
daemonize no
requirepass 密码
```
## 5. 创建容器，设置端口映射

```shell
docker run -p 6379:6379 \
--restart=always \
--name redis \
-v /usr/local/docker/redis/redis.conf:/etc/redis/redis.conf  \
-v /usr/local/docker/redis/data:/data \
-d redis:latest redis-server /etc/redis/redis.conf \
--appendonly yes
```

> 如果需要修改密码,修改`requirepass`配置然后重启容器`docker restart redis`
> 
> 其他配置同理

## 6. 连接redis
 - 进入docker容器
```shell
docker exec -it redis redis-cli
```
 - 使用外部机器连接redis

```shell
# -a后面为reids密码
redis-cli -h 192.168.0.181 -p 6379 -a redis
```



>Docker安装 rebloom

redis布隆过滤器

```sh
# 拉取镜像
docker pull redislabs/rebloom:latest
# 创建容器
docker run -p 6379:6379 \
--restart=always \
--name redisbloom \
-d redislabs/rebloom:latest  
# 进入容器
docker exec -it redisbloom bash
root@ca96f02a2d3c:/data# redis-cli
127.0.0.1:6379> config set requirepass foobared
OK
127.0.0.1:6379> config set requirepass 123456
OK
127.0.0.1:6379> exit
```

默认用户  default[参考 ](https://blog.csdn.net/weixin_38858749/article/details/124686796)



**提示Windows创建容器**

>Windows下映射路径不能出现空格和中文

```powershell
docker run -p 6379:6379 --restart=always --name redis -v C:/Users/dousx/.data/.docker/redis/redis.conf:/etc/redis/redis.conf  -d redis redis-server /etc/redis/redis.conf --appendonly yes
```

