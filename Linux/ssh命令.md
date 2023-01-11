## ssh命令

```powershell
# ssh –p端口号 用户名@IP地址
ssh –p22 root@192.168.0.183
```

### 主机公钥确认 `StrictHostKeyChecking`

1. `StrictHostKeyChecking=no` 最不安全的级别，当然也没有那么多烦人的提示了，相对安全的内网**测试**时建议使用。如果连接**server**的key在本地不存在，那么就自动添加到文件中（默认是known_hosts），并且给出一个警告。
2. `StrictHostKeyChecking=ask` 默认的级别，就是出现刚才的提示了。如果连接和key不匹配，给出提示，并拒绝登录。
3. `StrictHostKeyChecking=yes` 最安全的级别，如果连接与key不匹配，就拒绝连接，不会提示详细信息。

- 临时解决
```powershell
# 连接的时候指定
ssh -o StrictHostKeyChecking=no –p22 root@192.168.0.183
```
- 一劳永逸型

```sh
# ~/.ssh/config 中添加如下信息
Host *
  StrictHostKeyChecking no
```

## SSH免密登录

当前用户.ssh目录生成`id_rsa.pub`

将`id_rsa.pub`复制一份重命名为`d_rsa.pub.windows`,上传到Linux服务器

然后写入到下`.ssh/authorized_keys `

```sh
~ # cd .ssh                                                                                    
~/.ssh # ls                                                                                    
authorized_keys  id_rsa  id_rsa.pub  known_hosts  settings.xml                                 
~/.ssh # cat authorized_keys                                                                   
~/.ssh # cd ..                                                                                 
~ # cat d_rsa.pub.windows >> .ssh/authorized_keys                                         
~ # cat .ssh/authorized_keys                                                                   
```


