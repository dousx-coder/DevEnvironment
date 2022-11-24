# Ubuntu安装Docker

## 1. 安装Docker和docker-compose

### 一键安装
 ```sh
 # 官方脚本安装
 curl -fsSL https://get.docker.com | bash -s docker --mirror Aliyun
 ```
### 手动安装
卸载旧版本，旧版本被叫做docker、docker.io或者docker-engine。

```sh
sudo apt-get remove docker docker-engine docker.io containerd runc
```

更新apt包索引，并允许apt通过https更新repo

```sh
sudo apt update -y
sudo apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common -y
```

添加Docker的官方 GPG key

```sh
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
```

`9DC8 5822 9FC7 DD38 854A E2D8 8D81 803C 0EBF CD88` 通过搜索指纹的后8个字符，验证您现在是否拥有带有指纹的密钥

```sh
sudo apt-key fingerprint 0EBFCD88
pub   rsa4096 2017-02-22 [SCEA]
      9DC8 5822 9FC7 DD38 854A  E2D8 8D81 803C 0EBF CD88
uid           [ 未知 ] Docker Release (CE deb) <docker@docker.com>
sub   rsa4096 2017-02-22 [S]
```

使用以下命令来设置稳定的存储库

```sh
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
```

- ```sh
  正在读取软件包列表... 完成
  E: 仓库 “https://download.docker.com/linux/ubuntu impish Release” 没有 Release 文件。
  N: 无法安全地用该源进行更新，所以默认禁用该源。
  N: 参见 apt-secure(8) 手册以了解仓库创建和用户配置方面的细节。
  ```

- 解决方案

- ```sh
  root@brother:~# cd /etc/apt/sources.list.d
  root@brother:/etc/apt/sources.list.d# ls
  docker.list
  root@brother:/etc/apt/sources.list.d# rm docker.list 
  root@brother:/etc/apt/sources.list.d# apt-get update && apt-get upgrade
  ```

安装docker，顺便安装docker-compose

```sh
sudo apt-get update -y && apt-get upgrade -y
sudo apt install docker docker-compose -y
```

安装完成后，使用如下命令查看安装的docker版本：

```
docker --version
```
设置开机启动
```
sudo systemctl enable docker
```

## 2. 免sudo运行

默认情况下，普通用户没有权限执行 docker 相关操作, 我们需要将普通用户加入到 docker 组

```sh
sudo usermod -aG docker [用户名]
docker info
```

然后退出 shell 重新登录，即可不使用 sudo 来运行 docker 相关操作

## 3. 镜像加速

使用阿里云免费镜像加速器：https://cr.console.aliyun.com/cn-hangzhou/instances/mirrors