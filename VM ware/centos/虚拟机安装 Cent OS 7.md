# 虚拟机安装 Cent OS 7

## 1.安装vm

略

## 2.Cent OS 安装成功之后需要设置ip

```shell
vi /etc/sysconfig/network-scripts/ifcfg-ens33
```
> 其中ONBOOT改为yes
>
> 新增GATEWAY，IPADDR,NETMASK配置
```
TYPE=Ethernet
PROXY_METHOD=none
BROWSER_ONLY=no
BOOTPROTO=dhcp
DEFROUTE=yes
IPV4_FAILURE_FATAL=no
IPV6INIT=yes
IPV6_AUTOCONF=yes
IPV6_DEFROUTE=yes
IPV6_FAILURE_FATAL=no
IPV6_ADDR_GEN_MODE=stable-privacy
NAME=ens33
UUID=6c2e7034-579f-48c8-a1ca-ee7a0060dea2
DEVICE=ens33
ONBOOT=yes
GATEWAY=192.168.174.2
IPADDR=192.168.174.180
NETMASK=255.255.255.0
```

## 3.关闭防火墙

```sh
# 关闭
service firewalld stop

 #禁止firewall开机启动
systemctl disable firewalld.service       
```

### 3.1或者设置放行端口

```sh
# 查看已开放的端口 
firewall-cmd --zone=public --list-ports  

# 添加8484端口到白名单 执行
firewall-cmd --permanent --zone=public --add-port=8484/tcp
```

## 4.配置源地址

```sh
 vim /etc/yum.repos.d/CentOS-Base.repo
```

>内容如下，采用清华源

```repo
# CentOS-Base.repo
#
# The mirror system uses the connecting IP address of the client and the
# update status of each mirror to pick mirrors that are updated to and
# geographically close to the client.  You should use this for CentOS updates
# unless you are manually picking other mirrors.
#
# If the mirrorlist= does not work for you, as a fall back you can try the
# remarked out baseurl= line instead.
#
#

[base]
name=CentOS-$releasever - Base
baseurl=https://mirrors.tuna.tsinghua.edu.cn/centos/$releasever/os/$basearch/
#mirrorlist=http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=os
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7

#released updates
[updates]
name=CentOS-$releasever - Updates
baseurl=https://mirrors.tuna.tsinghua.edu.cn/centos/$releasever/updates/$basearch/
#mirrorlist=http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=updates
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7

#additional packages that may be useful
[extras]
name=CentOS-$releasever - Extras
baseurl=https://mirrors.tuna.tsinghua.edu.cn/centos/$releasever/extras/$basearch/
#mirrorlist=http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=extras
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7

#additional packages that extend functionality of existing packages
[centosplus]
name=CentOS-$releasever - Plus
baseurl=https://mirrors.tuna.tsinghua.edu.cn/centos/$releasever/centosplus/$basearch/
#mirrorlist=http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=centosplus
gpgcheck=1
enabled=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7
```

> 修改完成后执行

```sh
yum clean all
rm -rf  /var/cache/yum/
yum makecache
```

