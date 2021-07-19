```
# 开启
service firewalld start
# 重启
service firewalld restart
# 关闭
service firewalld stop

 #禁止firewall开机启动
systemctl disable firewalld.service       

# 查看已开放的端口 
firewall-cmd --zone=public --list-ports  

# 添加8484端口到白名单 执行
firewall-cmd --permanent --zone=public --add-port=8484/tcp

```

