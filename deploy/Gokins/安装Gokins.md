# 安装gokins

> https://gitee.com/gokins/gokins
>
> http://gokins.cn/

下载

```sh
wget http://bin.gokins.cn/gokins-linux-amd64
```
注册到service
```sh
vim /etc/systemd/system/gokins.service
```

内容如下

`/usr/local/share/gokins/gokins-linux-amd64`是`gokins`执行命令

```sh
[Unit]
Description=gokins
After=network.target
Wants=network.target

[Service]
TimeoutStartSec=30
ExecStart=/usr/local/share/gokins/gokins-linux-amd64
ExecStop=/bin/kill -9 $MAINPID

RestartSec=10
Restart=always

[Install]
WantedBy=multi-user.target
```

命令

```sh
# 启动
systemctl start gokins.service
systemctl stop gokins.service
# 设置开机启动
systemctl enable gokins.service
```
