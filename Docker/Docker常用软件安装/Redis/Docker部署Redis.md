### 部署Redis

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

>Docker安装redis布隆过滤器

```sh
#
docker search rebloom
#
docker pull redislabs/rebloom:latest
#
docker run -p 6379:6379 \
--restart=always \
--name redisbloom \
-d redislabs/rebloom:latest  
```

### 提示

>如果win上映射文件目录，文件目录中间不要出现空格

例如：

```
docker run -p 6379:6379 --restart=always --name redis -v c:/docker_data/redis/redis.conf:/etc/redis/redis.conf  -d redis redis-server /etc/redis/redis.conf --appendonly yes
```

