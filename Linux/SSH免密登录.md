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
