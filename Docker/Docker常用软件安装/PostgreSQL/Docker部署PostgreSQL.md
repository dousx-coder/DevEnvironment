### Docker部署PostgreSQL

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

>Win
>
```powershell
docker run -d  --name postgres --restart=always -e POSTGRES_PASSWORD=root -v  C:/Users/dousx/.data/.docker/postgres9.5:/var/lib/postgresql/data -p 5432:5432 postgres:9.5
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