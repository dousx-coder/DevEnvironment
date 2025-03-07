# Docker部署Redis

## 1. 搜索redis镜像

```shell
docker search redis
```
## 2. 拉取redis镜像
```shell
docker pull redis:7.4.2-alpine
```
## 3. 创建容器并指定密码
```sh
docker run -d --name redis \
--restart=always \
-p 6379:6379 \
redis:7.4.2-alpine \
--bind 0.0.0.0 \
--requirepass "fsv234vs2323"
```

默认用户  default[参考 ](https://blog.csdn.net/weixin_38858749/article/details/124686796)


**提示Windows下映射路径不能出现空格和中文**

```powershell
docker run -d --name redis --restart=always -p 6379:6379 redis:7.4.2-alpine --bind 0.0.0.0 --requirepass "fsv234vs2323"
```

## 4.布隆过滤器
### 方式一：使用镜像`redislabs/rebloom`创建容器
### 方式二：创建容器之后编译安装
  - [参考](https://juejin.cn/post/7017431688372289543)
