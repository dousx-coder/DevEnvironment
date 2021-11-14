## Windows下Docker部署nginx

```sh
# 拉取镜像
docker pull nginx
```

```sh
#创建容器 82映射
docker run --name nginx -p 82:80 -d nginx --restart=always 
```

```powershell
# 进入容器
docker exec -it nginx /bin/bash
```

```sh
# 安装常用工具
apt update -y
 apt install vim  net-tools iputils-ping -y

```
```sh
# 切换到nginx配置目录下
cd /etc/nginx/conf.d/
# 备份默认配置
cp default.conf default.conf.bak
```


```sh
# 修改默认配置或者根据需要新建配置
vim default.conf
```

例

```conf
server {
    listen       80;
    listen  [::]:80;
    server_name  localhost;

    location /chat-service/ {
          proxy_set_header Host $host;
          proxy_set_header X-Real-IP $remote_addr;
          proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
          # 如果要代理docker宿主机服务 ip则通过ipconfig查询填入
          proxy_pass http://192.168.174.1:19851/;
    }

    error_page   500 502 503 504  /50x.html;
    location = /50x.html {
        root   /usr/share/nginx/html;
    }
}
```

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
