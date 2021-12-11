# docker安装jenkins

```shell
[root@centos ~]# docker pull doushaoxun/jenkins:0.1
0.1: Pulling from doushaoxun/jenkins
0bc3020d05f1: Pull complete 
ee3587ec32c3: Pull complete 
0bd0b3e8a1ee: Pull complete 
59ca37ffb87d: Pull complete 
68cd5251ac06: Pull complete 
7110d7e8a2df: Pull complete 
7f38f1736460: Pull complete 
59035010c134: Pull complete 
d2731f044bfe: Pull complete 
64dd11412f60: Pull complete 
62f1ac6f5afe: Pull complete 
4ab0ce55611a: Pull complete 
f9697063721e: Pull complete 
6efddd03e683: Pull complete 
c336f827328f: Pull complete 
412359c3b82c: Pull complete 
682b79afa43d: Pull complete 
Digest: sha256:1ea98dc46abd09337da56b79d160e76f2d12012748262c7ced577fd1e06fcd23
Status: Downloaded newer image for doushaoxun/jenkins:0.1
docker.io/doushaoxun/jenkins:0.1
[root@centos ~]# docker run -d --name jenkins -p 10001:8080 doushaoxun/jenkins:0.1
4dcf65f06663089bbb1b67519c2a45fbcd86190404ced6ae9af9ea2c6619ad24
[root@centos ~]# docker ps 
CONTAINER ID   IMAGE                    COMMAND                  CREATED         STATUS         PORTS                                                    NAMES
4dcf65f06663   doushaoxun/jenkins:0.1   "/sbin/tini -- /usr/…"   4 seconds ago   Up 2 seconds   50000/tcp, 0.0.0.0:10001->8080/tcp, :::10001->8080/tcp   jenkins
```

