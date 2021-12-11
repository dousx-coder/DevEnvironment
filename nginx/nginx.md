### nginx安装

```shell
yum -y install gcc pcre-devel zlib-devel openssl openssl-devel
```

```shell
tar -zxvf nginx-1.16.1.tar.gz
cd nginx-1.16.1
./configure --prefix=/usr/local/nginx
make && make install
```

##### 加入systemctl

```sh
vim /usr/lib/systemd/system/nginx.service
```

编辑内容

```sh
[Unit]                                                                                   
Description=nginx - high performance web server   
After=network.target remote-fs.target nss-lookup.target  

[Service]                                                           
Type=forking    
PIDFile=/usr/local/nginx/logs/nginx.pid       
ExecStartPre=/usr/local/nginx/sbin/nginx -t -c /usr/local/nginx/conf/nginx.conf  
ExecStart=/usr/local/nginx/sbin/nginx -c /usr/local/nginx/conf/nginx.conf
ExecReload=/usr/local/nginx/sbin/nginx -s reload               
ExecStop=/usr/local/nginx/sbin/nginx -s stop  
ExecQuit=/usr/local/nginx/sbin/nginx -s quit 
PrivateTmp=true  

[Install]
WantedBy=multi-user.target  
```



```sh
[Unit]                                                                                      //对服务的说明
Description=nginx - high performance web server              //描述服务
After=network.target remote-fs.target nss-lookup.target   //描述服务类别

[Service]              //服务的一些具体运行参数的设置
Type=forking             //后台运行的形式
PIDFile=/usr/local/nginx/logs/nginx.pid     //PID文件的路径
ExecStartPre=/usr/local/nginx/sbin/nginx -t -c /usr/local/nginx/conf/nginx.conf //启动准备
ExecStart=/usr/local/nginx/sbin/nginx -c /usr/local/nginx/conf/nginx.conf    //启动命令
ExecReload=/usr/local/nginx/sbin/nginx -s reload                             //重启命令
ExecStop=/usr/local/nginx/sbin/nginx -s stop                                //停止命令
ExecQuit=/usr/local/nginx/sbin/nginx -s quit                                 //快速停止
PrivateTmp=true                                                  //给服务分配临时空间

[Install]
WantedBy=multi-user.target                                               //服务用户的模式
```

```
chmod +x /usr/lib/systemd/system/nginx.service
```

```sh
systemctl daemon-reload
systemctl start nginx.service
systemctl enable nginx # 开机启动
systemctl start nginx
systemctl stop nginx
systemctl restart nginx
systemctl status nginx
```

