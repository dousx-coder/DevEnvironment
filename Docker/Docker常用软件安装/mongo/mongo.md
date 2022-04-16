# Docker安装mongo

## 1.拉取镜像

```sh
docker pull mongo
```

## 2.创建容器

```sh
docker run -d --name mongo -p 27017:27017  mongo --auth
```

- `--auth`是设置开启身份验证

创建用户设置密码

```sh
docker exec -it mongo mongo admin
```

创建用户

```sh
db.createUser({
      "user": "dousx",
      "pwd": "mongopw...",
      "roles": [
        {
          "role": "userAdminAnyDatabase",
          "db": "admin"
        }
      ]
    });
```

![image-20220312123706695](https://cruder-figure-bed.oss-cn-beijing.aliyuncs.com/markdown/2022/03/12/12-37-07-001.png)