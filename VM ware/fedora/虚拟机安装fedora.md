# 虚拟机安装fedora
## 固定ip
1. 固定ip,其中`ens160`为网卡名
```sh
sudo nmcli conn modify ens160 ipv4.addresses 192.168.111.180/24 ipv4.gateway 192.168.111.2 ipv4.dns "8.8.8.8 8.8.4.4" ipv4.method manual
```
2. 重启
```sh
systemctl restart NetworkManager
```

### 其他命令
```sh
# 查看网卡
nmcli device

# 网卡详细信息
nmcli device show [网卡名]

# 查看连接
nmcli connection


# 查看连接详细信息
nmcli connection show [连接id]
```
