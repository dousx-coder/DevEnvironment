# Docker部署安装yapi框架

### 1、启动 MongoDB

```sh
docker run -d --name mongo-yapi mongo
```

### 2、获取 Yapi 镜像，版本信息可在 阿里云[镜像仓库](https://cloud.tencent.com/product/tcr?from=10680) 查看

```
docker pull registry.cn-hangzhou.aliyuncs.com/anoy/yapi
```

### 3、初始化 Yapi [数据库](https://cloud.tencent.com/solution/database?from=10680)索引及管理员账号

```
docker run -it --rm \
  --link mongo-yapi:mongo \
  --entrypoint npm \
  --workdir /api/vendors \
  registry.cn-hangzhou.aliyuncs.com/anoy/yapi \
  run install-server
```

### 4、启动 Yapi 服务

```sh
docker run -d \
  --name yapi \
  --link mongo-yapi:mongo \
  --workdir /api/vendors \
  -p 3000:3000 \
  registry.cn-hangzhou.aliyuncs.com/anoy/yapi \
  server/app.js
```
### 5、使用 Yapi

```sh
访问 http://localhost:3000   登录账号 admin@admin.com，密码 ymfe.org
```



![image-20220421163952883](https://cruder-figure-bed.oss-cn-beijing.aliyuncs.com/markdown/2022/04/21/04-39-53-121.png)

### 6、数据导入

![image-20220421164133589](https://cruder-figure-bed.oss-cn-beijing.aliyuncs.com/markdown/2022/04/21/04-41-33-800.png)
