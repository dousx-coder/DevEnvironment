# docker-compose安装

```sh
[root@centos ~]# curl -L https://get.daocloud.io/docker/compose/releases/download/1.27.4/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   423  100   423    0     0    421      0  0:00:01  0:00:01 --:--:--   422
100 11.6M  100 11.6M    0     0  5148k      0  0:00:02  0:00:02 --:--:-- 13.8M
[root@centos ~]# sudo chmod +x /usr/local/bin/docker-compose
[root@centos ~]# sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
[root@centos ~]# docker-compose version
docker-compose version 1.27.4, build 40524192
docker-py version: 4.3.1
CPython version: 3.7.7
OpenSSL version: OpenSSL 1.1.0l  10 Sep 2019
[root@centos ~]#
```

