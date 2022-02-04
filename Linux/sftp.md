# Sftp传输文件

- `ls`是远程服务器文件

- `lls`是当前服务器文件

- `put 文件`是将当前文件传送到远程服务器

```sh
~ # sftp root@192.168.174.204                                                                 
root@192.168.174.204's password:
Connected to 192.168.174.204.
sftp> ls
logs  snap
sftp> lls
jsch-0.1.53.jar  snap
sftp> put jsch-0.1.53.jar
Uploading jsch-0.1.53.jar to /root/jsch-0.1.53.jar
jsch-0.1.53.jar                                                  100%  277KB  20.7MB/s   00:00
sftp> ls
jsch-0.1.53.jar  logs             snap
sftp>
```



![image-20220204195236561](https://cruder-figure-bed.oss-cn-beijing.aliyuncs.com/markdown/2022/02/04/07-52-36-826.png)
