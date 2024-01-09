## Docker部署nginx

###  拉取镜像
```sh
docker pull nginx
```
### 创建容器
```sh
docker run --restart=always --name nginx -p 81:81 -p 82:82 -d nginx
```
###  进入容器
```sh
docker exec -it nginx /bin/bash
```
###  安装常用工具
```sh
# 需要先 update一下 否则无法下载
apt update -y
apt install vim tree net-tools iputils-ping -y
```
###  配置
```sh
# 切换到nginx配置目录下
cd /etc/nginx/conf.d/
# 备份默认配置
cp default.conf default.conf.bak
```


```sh
# 修改默认配置或者根据需要新建配置
vim server_82.conf
```

> 例 vim server_82.conf

```conf
server {
    listen       82;
    listen  [::]:82;
    server_name  localhost;

    location /chat-service/ {
          proxy_set_header Host $host;
          proxy_set_header X-Real-IP $remote_addr;
          proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
          # 如果要代理docker宿主机服务 ip则通过ipconfig查询填入,linux和win稍有不同
          proxy_pass http://192.168.174.1:19851/;
    }
    error_page   500 502 503 504  /50x.html;
    location = /50x.html {
        root   /usr/share/nginx/html;
    }
}
```
#### 负载均衡配置

```sh
upstream gateway_servers {
        server 192.168.174.202:8601;
        server 192.168.174.202:8602;
        server 192.168.174.202:8603;
}
server {
    listen       80;
    listen  [::]:80;
    server_name  localhost;

    location /cloud-gateway/ {
          proxy_set_header Host $host;
          proxy_set_header X-Real-IP $remote_addr;
          proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
          proxy_pass http://gateway_servers/;
    }
    error_page   500 502 503 504  /50x.html;
    location = /50x.html {
        root   /usr/share/nginx/html;
    }
}
```
#### Linux查看docker宿主机ip

> ifconfig 找到docker0的ip，可以代理docker宿主机的服务

```sh
~ # ifconfig                                                                                  
docker0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 172.17.0.1  netmask 255.255.0.0  broadcast 172.17.255.255
        inet6 fe80::42:d4ff:fe61:9861  prefixlen 64  scopeid 0x20<link>
        ether 02:42:d4:61:98:61  txqueuelen 0  (Ethernet)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 8  bytes 800 (800.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
~ # ip addr show docker0                                                                       
3: docker0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default
    link/ether 02:42:d4:61:98:61 brd ff:ff:ff:ff:ff:ff
    inet 172.17.0.1/16 brd 172.17.255.255 scope global docker0
       valid_lft forever preferred_lft forever
    inet6 fe80::42:d4ff:fe61:9861/64 scope link
       valid_lft forever preferred_lft forever
```

#### Windows查看docker宿主机ip 

查看win配置找到docker网络配置（172.25.224.1）

>以太网适配器 vEthernet (Default Switch)每次开机会变，这里以太网适配器 VMware Network Adapter VMnet8的ip是固定的，且容器能ping通，故配置采用192.168.174.1

```powershell
PS C:\Users\dousx> ipconfig

Windows IP 配置


以太网适配器 以太网:

   媒体状态  . . . . . . . . . . . . : 媒体已断开连接
   连接特定的 DNS 后缀 . . . . . . . :

以太网适配器 vEthernet (Default Switch):

   连接特定的 DNS 后缀 . . . . . . . :
   本地链接 IPv6 地址. . . . . . . . : fe80::b8a5:915d:9d76:fbd5%13
   IPv4 地址 . . . . . . . . . . . . : 172.25.224.1
   子网掩码  . . . . . . . . . . . . : 255.255.240.0
   默认网关. . . . . . . . . . . . . :

以太网适配器 vEthernet (WSL):

   连接特定的 DNS 后缀 . . . . . . . :
   本地链接 IPv6 地址. . . . . . . . : fe80::dda2:f523:a08a:50cf%29
   IPv4 地址 . . . . . . . . . . . . : 172.24.144.1
   子网掩码  . . . . . . . . . . . . : 255.255.240.0
   默认网关. . . . . . . . . . . . . :

无线局域网适配器 本地连接* 1:

   媒体状态  . . . . . . . . . . . . : 媒体已断开连接
   连接特定的 DNS 后缀 . . . . . . . :

无线局域网适配器 本地连接* 2:

   媒体状态  . . . . . . . . . . . . : 媒体已断开连接
   连接特定的 DNS 后缀 . . . . . . . :

以太网适配器 VMware Network Adapter VMnet1:

   连接特定的 DNS 后缀 . . . . . . . :
   本地链接 IPv6 地址. . . . . . . . : fe80::192:6c04:48d0:75dd%18
   IPv4 地址 . . . . . . . . . . . . : 192.168.163.1
   子网掩码  . . . . . . . . . . . . : 255.255.255.0
   默认网关. . . . . . . . . . . . . :

以太网适配器 VMware Network Adapter VMnet8:

   连接特定的 DNS 后缀 . . . . . . . :
   本地链接 IPv6 地址. . . . . . . . : fe80::54f4:e83:82d1:9fbb%14
   IPv4 地址 . . . . . . . . . . . . : 192.168.174.1
   子网掩码  . . . . . . . . . . . . : 255.255.255.0
   默认网关. . . . . . . . . . . . . :

无线局域网适配器 WLAN:

   连接特定的 DNS 后缀 . . . . . . . :
   本地链接 IPv6 地址. . . . . . . . : fe80::c9a8:bcb2:122c:7ae3%3
   IPv4 地址 . . . . . . . . . . . . : 192.168.0.108
   子网掩码  . . . . . . . . . . . . : 255.255.255.0
   默认网关. . . . . . . . . . . . . : 192.168.0.1
```






```
    #  jmix 里有vaadinServlet 需要配置server.servlet.context-path=/erep
    location /erep/ {
        proxy_set_header X-Forwarded-Host $host;
        proxy_set_header X-Forwarded-Server $host;
        proxy_read_timeout     3600;
        proxy_connect_timeout  240;
        proxy_set_header   X-Forwarded-For $remote_addr;
        proxy_http_version  1.1;
        proxy_set_header    Upgrade $http_upgrade;
        proxy_set_header    Connection "upgrade";
        proxy_set_header    Host $http_host;
        proxy_set_header    X-Real-IP $remote_addr;
        proxy_pass http://172.28.16.1:8271/erep/;
    }
```