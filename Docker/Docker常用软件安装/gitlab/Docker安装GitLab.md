# Docker安装GitLab

## 1. 拉取镜像

```sh
docker pull gitlab/gitlab-ce
```

## 2. 创建容器

创建挂在目录

```sh
mkdir -p /usr/local/docker/gitlab
```

创建容器

```sh
docker run --name='gitlab' -d --restart=always \
--publish 6001:80 --publish 6002:443  --publish 6003:22 \
-v /usr/local/docker/gitlab/etc:/etc/gitlab \
-v /usr/local/docker/gitlab/data:/var/opt/gitlab \
-v /usr/local/docker/gitlab/logs:/var/log/gitlab \
gitlab/gitlab-ce:latest
```

## 3. 修改root密码

### 3.1 进入容器

```sh
docker exec -it -u root gitlab /bin/bash
```

### 3.2 Ruby on Rails控制台

```sh
gitlab-rails console
```

### 3.3 查找root用户

等待控制台加载完毕并找到root用户，稍微要多等待一会

```sh
user = User.where(id: 1).first
```

### 3.4 更改密码

```sh
user.password='root2022...'
user.password_confirmation='root2022...'
user.save
```

```sh
/usr/local/docker # docker exec -it -u root gitlab /bin/bash  
root@f2dcc96d0954:/# gitlab-rails console
--------------------------------------------------------------------------------
 Ruby:         ruby 2.7.5p203 (2021-11-24 revision f69aeb8314) [x86_64-linux]
 GitLab:       14.6.1 (661d663ab2b) FOSS
 GitLab Shell: 13.22.1
 PostgreSQL:   12.7
--------------------------------------------------------------------------------
user = User.where(id: 1).first
Loading production environment (Rails 6.1.4.1)
irb(main):001:0> user = User.where(id: 1).first
=> #<User id:1 @root>
irb(main):002:0> user.password='root2022...'
=> "root2022..."
irb(main):003:0> user.password_confirmation='root2022...'
=> "root2022..."
irb(main):004:0> user.save
=> true
irb(main):005:0> exit
root@f2dcc96d0954:/# exit
exit
```

![image-20220206134121607](https://cruder-figure-bed.oss-cn-beijing.aliyuncs.com/markdown/2022/02/06/01-41-21-864.png)

### 3.5 浏览器访问

浏览器打开http://192.168.174.205:6001/，用root账号以及刚设置的密码登录GitLab

![image-20220206134151267](https://cruder-figure-bed.oss-cn-beijing.aliyuncs.com/markdown/2022/02/06/01-41-51-513.png)

## 4.配置

>按上面的方式，GitLab容器运行没问题，但在GitLab上创建项目的时候，生成项目的URL访问地址是按容器的`hostname`来生成的，也就是容器id(如：`http://f2dcc96d0954/root/test.git`)。
>
>作为GitLab服务器，我们需要一个固定的URL访问地址

### 4.1 gitlab.rb

容器路径：`/etc/gitlab/gitlab.rb`

对应挂在路径`/usr/local/docker/gitlab/etc/gitlab.rb`

```sh
vim /usr/local/docker/gitlab/etc/gitlab.rb
```
`gitlab.rb`需要配置的内容（vim使用`/`查找）

```sh
# 在GitLab创建项目时候http地址的host(如果不加端口，端口默认为80)
external_url 'http://192.168.174.205:6001'

# 在GitLab创建项目时候ssh地址的host(不用添加端口，不用加http)
gitlab_rails['gitlab_ssh_host'] = '192.168.174.205'

# Docker run 的时候我们把22端口映射为外部的6003了，这里修改下
gitlab_rails['gitlab_shell_ssh_port'] = 6003
```
### 4.2 gitlab.yml

容器路径`var/opt/gitlab/gitlab-rails/etc/gitlab.yml`

对应挂在路径`/usr/local/docker/gitlab/data/gitlab-rails/etc/gitlab.yml`

```sh
vim /usr/local/docker/gitlab/data/gitlab-rails/etc/gitlab.yml
```

`修改前`

```yaml
production: &base
  #
  # 1. GitLab app settings
  # ==========================

  ## GitLab settings
  gitlab:
    ## Web server settings (note: host is the FQDN, do not include http://)
    host: f2dcc96d0954
    port: 80
    https: false
```

`修改后`

```yaml
production: &base
  gitlab:
    ## Web server settings (note: host is the FQDN, do not include http://)
    host: 192.168.174.205
    port: 6001
    https: false
```

**跳坑重点强调**

- 22端口映射问题：如果不映射22端口，ssh克隆时一直提示输入密码，且密码错误。ssh传输都是通过22端口传输的，一般被宿主的sshd服务占用。所以GitLab容器的22端口不能直接映射到宿主的22端口，要换个其他端口，比如6003。这样，通过端口映射，客户端的ssh传输请求就能达到容器中的GitLab服务。

- external_url默认为80端口问题：请注意，我上面的配置`external_url`是有写端口号`6001`的，如果不写，则默认为80端口。此处有两个坑：

第一个坑：如果`external_url`不写端口`6001`，而用默认的`80`端口，那项目的`Clone with HTTP`地址也是不带端口的(默认为`80`端口)，由于`80`端口的原因，我们在git clone http 地址时会clone失败。即要修改的`gitlab.yml`文件里，将`port`端口设置为`6001`，保存退出，当容器一启动再来看该文件内容，`port`又会变成默认的`80`端口。

第二个坑：如果`external_url`写了端口`6001`，重启配置，容器也能正常重启成功，但GitLab却访问不了了。问题的原因就出在external_url地址设置上。
 GitLab默认的http访问端口号为80端口，如果想更改端口号，一般是通过docker run时设置端口映射，将80端口映射为其他端口。

**删除容器，重写创建容器**

```sh
docker stop gitlab &  docker rm -f gitlab
```

```sh
docker run --name='gitlab' -d --restart=always \
--publish 6001:6001 --publish 6002:443  --publish 6003:22 \
-v /usr/local/docker/gitlab/etc:/etc/gitlab \
-v /usr/local/docker/gitlab/data:/var/opt/gitlab \
-v /usr/local/docker/gitlab/logs:/var/log/gitlab \
gitlab/gitlab-ce:latest
```

查看容器状态

```sh
docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Ports}}\t{{.Status}}" -a
```

## 5.创建项目

### 5.1 创建项目

![image-20220206140919814](https://cruder-figure-bed.oss-cn-beijing.aliyuncs.com/markdown/2022/02/06/02-09-20-131.png)

### 5.2 Clone项目

#### 5.2.1 **http** clone

![image-20220206141038937](https://cruder-figure-bed.oss-cn-beijing.aliyuncs.com/markdown/2022/02/06/02-10-39-178.png)

![image-20220206141054849](https://cruder-figure-bed.oss-cn-beijing.aliyuncs.com/markdown/2022/02/06/02-10-55-051.png)

#### 5.2.2 **ssh** clone

**添加ssh公钥**

![image-20220206141227496](https://cruder-figure-bed.oss-cn-beijing.aliyuncs.com/markdown/2022/02/06/02-12-27-889.png)

添加ssh公钥之后使用`SSH clone`项目

![image-20220206141337482](https://cruder-figure-bed.oss-cn-beijing.aliyuncs.com/markdown/2022/02/06/02-13-37-710.png)

### 5.3 push测试

![image-20220206141729794](https://cruder-figure-bed.oss-cn-beijing.aliyuncs.com/markdown/2022/02/06/02-17-30-071.png)

![image-20220206141914121](https://cruder-figure-bed.oss-cn-beijing.aliyuncs.com/markdown/2022/02/06/02-19-14-426.png)
