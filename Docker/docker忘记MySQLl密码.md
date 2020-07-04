
#### 1.进入容器
```
docker exec -it mysql bash
```

#### 2.设置跳过权限表的加载 
警告：这就意味着任何用户都能登录进来，并进行任何操作，相当不安全。

```
echo "skip-grant-tables" >> /etc/mysql/conf.d/docker.cnf
```

#### 3.退出容器
```
exit
```

#### 4.重启容器
```
docker restart mysql
```

#### 5.再次进入容器
```
docker exec -it mysql bash
```

#### 6.登录 mysql（无需密码）
```
mysql -uroot 
```

#### 7.更新权限
```
flush privileges;
```

#### 8.修改密码
```
alter user 'root'@'localhost' identified by '123456';
```

#### 9.退出mysql
```
exit
```

#### 10.替换掉刚才加的跳过权限表的加载参数
```
sed -i "s/skip-grant-tables/ /" /etc/mysql/conf.d/docker.cnf
```

#### 11.退出容器
```
exit
```

#### 12.重启容器
```
docker restart mysql
```