# Docker部署PostgreSQL

1. 拉取镜像

```shell
docker pull postgres:10
```
2. 目录映射

```
mkdir -p /usr/local/docker/postgresql10
```

3. 创建容器

```
docker run -d  \
--name postgres \
--restart=always \
-e POSTGRES_PASSWORD=root \
-v /usr/local/docker/postgresql10:/var/lib/postgresql/data \
-p 5432:5432 \
postgres:10
```

**Windows创建容器**

>挂载目录需要访问权限
>
>挂载目录不能包含中文和空格

```powershell
docker run -d  --name postgres --restart=always -e POSTGRES_PASSWORD=root -v  C:/Users/dousx/.data/.docker/postgres9.5:/var/lib/postgresql/data -p 5432:5432 postgres:9.5
```
4. 说明

- -e POSTGRES_PASSWORD=password，设置环境变量，指定数据库的登录口令为password

- -v /usr/local/docker/postgresql10:/var/lib/postgresql/data 挂载到容器目录
- 用户名:`postgres`, 密码:`root` , 端口`5432`