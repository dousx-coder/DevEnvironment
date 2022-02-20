# Docker 私服

## registry

> https://hub.docker.com/_/registry

### 私服环境

` 192.168.174.203`搭建

```sh
docker pull registry
docker run -itd -p 5000:5000 --name registry --restart=always registry:latest
```

### 测试服务器

`192.168.174.202`配置私服地址

```
 vim /etc/docker/daemon.json
```

添加`"insecure-registries":["192.168.174.203:5000"]`

```json
{
  "registry-mirrors": ["https://*********阿里云加速地址*******"],
  "insecure-registries":["192.168.174.203:5000"]
}
```

`重启`docker 

```sh
~ # systemctl daemon-reload                                                                     
~ # systemctl restart docker  
```

`docker info`查看到`Insecure Registries`存在私服地址

```sh
                                                                 
~ # docker info                                                                                 
Client:
 Context:    default
 Debug Mode: false
 Plugins:
  app: Docker App (Docker Inc., v0.9.1-beta3)
  buildx: Docker Buildx (Docker Inc., v0.7.1-docker)
  scan: Docker Scan (Docker Inc., v0.12.0)

Server:
 Containers: 0
  Running: 0
  Paused: 0
  Stopped: 0
 Images: 1
 Server Version: 20.10.12
 Storage Driver: overlay2
  Backing Filesystem: extfs
  Supports d_type: true
  Native Overlay Diff: true
  userxattr: false
 Logging Driver: json-file
 Cgroup Driver: cgroupfs
 Cgroup Version: 1
 Plugins:
  Volume: local
  Network: bridge host ipvlan macvlan null overlay
  Log: awslogs fluentd gcplogs gelf journald json-file local logentries splunk syslog
 Swarm: inactive
 Runtimes: io.containerd.runc.v1 io.containerd.runtime.v1.linux runc
 Default Runtime: runc
 Init Binary: docker-init
 containerd version: 7b11cfaabd73bb80907dd23182b9347b4245eb5d
 runc version: v1.0.2-0-g52b36a2
 init version: de40ad0
 Security Options:
  apparmor
  seccomp
   Profile: default
 Kernel Version: 5.4.0-100-generic
 Operating System: Ubuntu 20.04.3 LTS
 OSType: linux
 Architecture: x86_64
 CPUs: 2
 Total Memory: 7.741GiB
 Name: linux
 ID: 3JCQ:C457:SF5S:C5H4:SRQB:PDJB:W4WQ:GWM4:7XXR:O6FR:5UFM:S7XX
 Docker Root Dir: /var/lib/docker
 Debug Mode: false
 Registry: https://index.docker.io/v1/
 Labels:
 Experimental: false
 Insecure Registries:
  192.168.174.203:5000
  127.0.0.0/8
 Registry Mirrors:
  https://hcssn4ep.mirror.aliyuncs.com/
 Live Restore Enabled: false

WARNING: No swap limit support
~ #
```

#### 推送拉取测试

```sh
docker pull nginx:latest \
  && docker tag nginx:latest 192.168.174.203:5000/nginx:v1\
  && docker push 192.168.174.203:5000/nginx:v1 \
  && curl 'http://192.168.174.203:5000/v1/nginx/tags/list' \
  && docker rmi -f  nginx:latest 192.168.174.203:5000/nginx:v1 \
  && docker pull 192.168.174.203:5000/nginx:v1
```





## Harbor

### 安装 

> [harbor](https://github.com/goharbor/harbor/releases)

` 192.168.174.203`搭建

```sh
wget https://github.com/goharbor/harbor/releases/download/v2.4.1/harbor-offline-installer-v2.4.1.tgz
mkdir -p /opt/application/harbor/data
tar -zxvf harbor-offline-installer-v2.4.1.tgz -C /opt/application
cd /opt/application/harbor
cp harbor.yml.tmpl harbor.yml
```

配置`harbor.yml`

```
hostname: 192.168.174.203
```

![image-20220220144121432](https://cruder-figure-bed.oss-cn-beijing.aliyuncs.com/markdown/2022/02/20/02-41-21-709.png)

```sh
# 持久化目录
data_volume: /opt/application/harbor/data
```

执行安装程序

```sh
./install.sh
```

![image-20220220144403382](https://cruder-figure-bed.oss-cn-beijing.aliyuncs.com/markdown/2022/02/20/02-44-03-591.png)

成功

![image-20220220144720329](https://cruder-figure-bed.oss-cn-beijing.aliyuncs.com/markdown/2022/02/20/02-47-20-552.png)

浏览器访问

```
http://192.168.174.203/
```

### 测试服务器

`192.168.174.202`配置私服地址

修改Docker的配置文件`/etc/docker/daemon.json`

```
{
  "registry-mirrors": ["https://hcssn4ep.mirror.aliyuncs.com"],
  "insecure-registries":["192.168.174.203:80"]
}
```

登录
```sh
~ # docker login 192.168.174.203:80                                                             
Username: admin
Password:
WARNING! Your password will be stored unencrypted in /root/.docker/config.json.
Configure a credential helper to remove this warning. See
https://docs.docker.com/engine/reference/commandline/login/#credentials-store

Login Succeeded
```

打tag ` ip+端口/项目名称/镜像名称:tag`,其中`ng`项目需要在harbor中提前创建好

```sh
# 拉取镜像
docker pull nginx:latest 
# 打tage
docker tag nginx:latest 192.168.174.203:80/ng/nginx.2022.02.20:v1
# 推送
docker push 192.168.174.203:80/ng/nginx.2022.02.20:v1
```

完成测试

```sh
~ # docker images -a                                                                           
REPOSITORY   TAG       IMAGE ID   CREATED   SIZE
~ # docker pull nginx:latest                                                                   
latest: Pulling from library/nginx
a2abf6c4d29d: Pull complete
a9edb18cadd1: Pull complete
589b7251471a: Pull complete
186b1aaa4aa6: Pull complete
b4df32aa5a72: Pull complete
a0bcbecc962e: Pull complete
Digest: sha256:0d17b565c37bcbd895e9d92315a05c1c3c9a29f762b011a10c54a66cd53c9b31
Status: Downloaded newer image for nginx:latest
docker.io/library/nginx:latest
~ # docker tag nginx:latest 192.168.174.203:80/ng/nginx.2022.02.20:v1                           
~ # docker images -a                                                                           
REPOSITORY                               TAG       IMAGE ID       CREATED       SIZE
192.168.174.203:80/ng/nginx.2022.02.20   v1        605c77e624dd   7 weeks ago   141MB
nginx                                    latest    605c77e624dd   7 weeks ago   141MB
~ # docker push 192.168.174.203:80/ng/nginx.2022.02.20:v1                                       
The push refers to repository [192.168.174.203:80/ng/nginx.2022.02.20]
d874fd2bc83b: Layer already exists
32ce5f6a5106: Layer already exists
f1db227348d0: Layer already exists
b8d6e692a25e: Layer already exists
e379e8aedd4d: Layer already exists
2edcec3590a4: Layer already exists
v1: digest: sha256:ee89b00528ff4f02f2405e4ee221743ebc3f8e8dd0bfd5c4c20a2fa2aaa7ede3 size: 1570
~ # docker rmi 192.168.174.203:80/ng/nginx.2022.02.20:v1 nginx:latest -f                       
Untagged: 192.168.174.203:80/ng/nginx.2022.02.20:v1
Untagged: 192.168.174.203:80/ng/nginx.2022.02.20@sha256:ee89b00528ff4f02f2405e4ee221743ebc3f8e8dd0bfd5c4c20a2fa2aaa7ede3
Untagged: nginx:latest
Untagged: nginx@sha256:0d17b565c37bcbd895e9d92315a05c1c3c9a29f762b011a10c54a66cd53c9b31
Deleted: sha256:605c77e624ddb75e6110f997c58876baa13f8754486b461117934b24a9dc3a85
Deleted: sha256:b625d8e29573fa369e799ca7c5df8b7a902126d2b7cbeb390af59e4b9e1210c5
Deleted: sha256:7850d382fb05e393e211067c5ca0aada2111fcbe550a90fed04d1c634bd31a14
Deleted: sha256:02b80ac2055edd757a996c3d554e6a8906fd3521e14d1227440afd5163a5f1c4
Deleted: sha256:b92aa5824592ecb46e6d169f8e694a99150ccef01a2aabea7b9c02356cdabe7c
Deleted: sha256:780238f18c540007376dd5e904f583896a69fe620876cabc06977a3af4ba4fb5
Deleted: sha256:2edcec3590a4ec7f40cf0743c15d78fb39d8326bc029073b41ef9727da6c851f
~ # docker images -a                                                                           
REPOSITORY   TAG       IMAGE ID   CREATED   SIZE
~ # docker pull 192.168.174.203:80/ng/nginx.2022.02.20:v1                                       
v1: Pulling from ng/nginx.2022.02.20
a2abf6c4d29d: Pull complete
a9edb18cadd1: Pull complete
589b7251471a: Pull complete
186b1aaa4aa6: Pull complete
b4df32aa5a72: Pull complete
a0bcbecc962e: Pull complete
Digest: sha256:ee89b00528ff4f02f2405e4ee221743ebc3f8e8dd0bfd5c4c20a2fa2aaa7ede3
Status: Downloaded newer image for 192.168.174.203:80/ng/nginx.2022.02.20:v1
192.168.174.203:80/ng/nginx.2022.02.20:v1
~ # docker images -a                                                                           
REPOSITORY                               TAG       IMAGE ID       CREATED       SIZE
192.168.174.203:80/ng/nginx.2022.02.20   v1        605c77e624dd   7 weeks ago   141MB
```



![image-20220220145742981](https://cruder-figure-bed.oss-cn-beijing.aliyuncs.com/markdown/2022/02/20/02-57-43-311.png)

私服中查看结果

![image-20220220135934382](https://cruder-figure-bed.oss-cn-beijing.aliyuncs.com/markdown/2022/02/20/01-59-34-660.png)