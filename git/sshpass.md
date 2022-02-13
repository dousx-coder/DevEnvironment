# sshpass
安装

```sh
apt install sshpass -y
```

查看版本

```sh
sshpass -V
```



上传文件

`-p`后面是密码

```sh
sshpass -p dousx... \
scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no  \
target/es-ext-dic.jar root@192.168.174.202:/usr/local/program/es-ext-dic/es-ext-dic.jar
```



执行远程命令

```sh
sshpass -p dousx...  \
ssh  -o StrictHostKeyChecking=no root@192.168.174.202  \
sh /usr/local/program/es-ext-dic/app.sh restart
```