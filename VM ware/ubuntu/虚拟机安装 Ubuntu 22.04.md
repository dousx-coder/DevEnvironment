## 虚拟机安装 Ubuntu 22.4
#### 修改虚拟机名称
```sh
# 默认是很长的字符串，太占空间，也可在安装时候改好。
sudo vim /etc/hostname
sudo vim /etc/hosts
```
#### 修改root密码
```sh
安装完成root没有密码，设置密码，在learn用户下切换到root，但是不能使用root登入图形界面。
sudo passwd root
#输入密码
切换用户
su root
```
#### 查看网络配置
```sh
ifconfig
#如果没有则安装：
apt install net-tools
```
#### 安装ssh
```sh
#安装命令
apt-get install openssh-server
#启动
/etc/init.d/ssh start
#查看是否安装成功
netstat -ntlp
ps -e|grep ssh
```
#### root允许远程登录

```sh
 vim /etc/ssh/sshd_config
```

修改内容如下: prohibit-password改为yes,Port 22 关闭注释

```sh
Include /etc/ssh/sshd_config.d/*.conf

Port 22
#AddressFamily any
#ListenAddress 0.0.0.0
#ListenAddress ::

#HostKey /etc/ssh/ssh_host_rsa_key
#HostKey /etc/ssh/ssh_host_ecdsa_key
#HostKey /etc/ssh/ssh_host_ed25519_key

# Ciphers and keying
#RekeyLimit default none

# Logging
#SyslogFacility AUTH
#LogLevel INFO

# Authentication:

#LoginGraceTime 2m
#PermitRootLogin prohibit-password
PermitRootLogin yes
```

```sh
#重启
sudo  service sshd restart
```

#### 防火墙信息

```sh
#启动防火墙
sudo ufw enable
#关闭防火墙
sudo ufw disable
#防火墙状态
sudo ufw status
```



#### vm ubuntu 20 固定ip

```sh
dousx@linux:~$ cd /etc/netplan/ && ls 
01-network-manager-all.yaml
dousx@linux:/etc/netplan$ sudo vim 01-network-manager-all.yaml 
dousx@linux:/etc/netplan$ 
```
01-network-manager-all.yaml 配置修改如下
```yml
# Let NetworkManager manage all devices on this system
network:
  ethernets:
    #配置的网卡的名称
    ens33:    
      #配置的静态ip地址和掩码
      addresses: [192.168.174.201/24]    
      #关闭DHCP，如果需要打开DHCP则写yes
      dhcp4: no   
      optional: true
      #网关地址
      gateway4: 192.168.174.2   
      nameservers:
        #DNS服务器地址，多个DNS服务器地址需要用英文逗号分隔开
        addresses: [8.8.8.8,8.8.4.4]    
  version: 2
  #指定后端采用systemd-networkd或者Network Manager，可不填写则默认使用systemd-workd
  renderer: networkd    

```

```sh
# 让配置生效
sudo netplan apply
```

#### 设置启动模式（命令行/图形化）

```sh
# 默认进入命令行界面
sudo systemctl set-default multi-user.target  
# 默认进入图形界面
sudo systemctl set-default graphical.target   
```

#### 设置国内源

```sh
sudo vim /etc/apt/sources.list
```

添加如下内容

```sh
# 中科大
deb https://mirrors.ustc.edu.cn/ubuntu/ focal main restricted universe multiverse
deb-src https://mirrors.ustc.edu.cn/ubuntu/ focal main restricted universe multiverse
deb https://mirrors.ustc.edu.cn/ubuntu/ focal-updates main restricted universe multiverse
deb-src https://mirrors.ustc.edu.cn/ubuntu/ focal-updates main restricted universe multiverse
deb https://mirrors.ustc.edu.cn/ubuntu/ focal-backports main restricted universe multiverse
deb-src https://mirrors.ustc.edu.cn/ubuntu/ focal-backports main restricted universe multiverse
deb https://mirrors.ustc.edu.cn/ubuntu/ focal-security main restricted universe multiverse
deb-src https://mirrors.ustc.edu.cn/ubuntu/ focal-security main restricted universe multiverse
deb https://mirrors.ustc.edu.cn/ubuntu/ focal-proposed main restricted universe multiverse
deb-src https://mirrors.ustc.edu.cn/ubuntu/ focal-proposed main restricted universe multiverse
# 阿里
deb http://mirrors.aliyun.com/ubuntu/ focal main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ focal main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ focal-security main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ focal-security main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ focal-updates main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ focal-updates main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ focal-proposed main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ focal-proposed main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ focal-backports main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ focal-backports main restricted universe multiverse
# 网易163
deb http://mirrors.163.com/ubuntu/ focal main restricted universe multiverse
deb http://mirrors.163.com/ubuntu/ focal-security main restricted universe multiverse
deb http://mirrors.163.com/ubuntu/ focal-updates main restricted universe multiverse
deb http://mirrors.163.com/ubuntu/ focal-proposed main restricted universe multiverse
deb http://mirrors.163.com/ubuntu/ focal-backports main restricted universe multiverse
deb-src http://mirrors.163.com/ubuntu/ focal main restricted universe multiverse
deb-src http://mirrors.163.com/ubuntu/ focal-security main restricted universe multiverse
deb-src http://mirrors.163.com/ubuntu/ focal-updates main restricted universe multiverse
deb-src http://mirrors.163.com/ubuntu/ focal-proposed main restricted universe multiverse
deb-src http://mirrors.163.com/ubuntu/ focal-backports main restricted universe multiverse
```

刷新列表

```sh
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install build-essential
```

### vim配置

`vim /etc/vim/vimrc`追加

```
set nu
syntax on
set  ruler
set hlsearch
set ignorecase
set noswapfile
set undofile
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8
```

