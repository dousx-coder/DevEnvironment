# Nginx配置负载均衡

```sh
root@83b0c83d641d:~# cd /etc/nginx/conf.d
root@83b0c83d641d:/etc/nginx/conf.d# vim server_82.conf
root@83b0c83d641d:/etc/nginx/conf.d# cat server_82.conf
    upstream chat.com{
        server 172.17.0.1:19851 weight=1;
        server 172.17.0.1:19852 weight=2;
    }

    server {
        listen       82;
        server_name  localhost;

        location / {
            proxy_pass http://chat.com;
            proxy_redirect default;
        }

        error_page   500 502 503 504  /50x.html;
        location = /50x.html {
            root   html;
        }
    }
root@83b0c83d641d:/etc/nginx/conf.d#
```

server_82.conf配置如下：

> ```sh
>     location /chat-service/ {
>         proxy_pass http://chat.com;
>         proxy_redirect default;
>     }
> ```
> 
> 加了路径分割失效，待研究
> 
> 


```shell
    upstream chat.com{
        server 172.17.0.1:19851 weight=1;
        server 172.17.0.1:19852 weight=2;
    }

    server {
        listen       82;
        server_name  localhost;

        location / {
            proxy_pass http://chat.com;
            proxy_redirect default;
        }

        error_page   500 502 503 504  /50x.html;
        location = /50x.html {
            root   html;
        }
    }
```

