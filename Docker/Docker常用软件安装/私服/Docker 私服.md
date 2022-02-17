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





