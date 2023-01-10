# 安装ubuntu之后需要做的事
## 1. 设置root密码
```sh
sudo passwd root
```

## 2.设置国内源
1. 备份
```sh
sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak
```
2. `/etc/apt/sources.list`添加如下内容
```sh
sudo vim /etc/apt/sources.list
```

```sh
# 中科大
deb https://mirrors.ustc.edu.cn/ubuntu/ focal main restricted universe multiverse
deb-src https://mirrors.ustc.edu.cn/ubuntu/ focal main restricted universe multiverse
deb https://mirrors.ustc.edu.cn/ubuntu/ focal-updates main restricted universe multiverse
deb-src https://mirrors.ustc.edu.cn/ubuntu/ focal-updates main restricted universe multiverse
deb https://mirrors.ustc.edu.cn/ubuntu/ focal-backports main restricted universe multiverse
deb-src https://mirrors.ustc.edu.cn/ubuntu/ focal-backports main restricted universe multiverse
deb https://mirrors.ustc.edu.cn/ubuntu/ focal-security main restricted universe multiverse
deb-src https://mirrors.ustc.edu.cn/ubuntu/ focal-security main restricted universe multiverse
deb https://mirrors.ustc.edu.cn/ubuntu/ focal-proposed main restricted universe multiverse
deb-src https://mirrors.ustc.edu.cn/ubuntu/ focal-proposed main restricted universe multiverse
# 阿里
deb http://mirrors.aliyun.com/ubuntu/ focal main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ focal main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ focal-security main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ focal-security main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ focal-updates main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ focal-updates main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ focal-proposed main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ focal-proposed main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ focal-backports main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ focal-backports main restricted universe multiverse
# 网易163
deb http://mirrors.163.com/ubuntu/ focal main restricted universe multiverse
deb http://mirrors.163.com/ubuntu/ focal-security main restricted universe multiverse
deb http://mirrors.163.com/ubuntu/ focal-updates main restricted universe multiverse
deb http://mirrors.163.com/ubuntu/ focal-proposed main restricted universe multiverse
deb http://mirrors.163.com/ubuntu/ focal-backports main restricted universe multiverse
deb-src http://mirrors.163.com/ubuntu/ focal main restricted universe multiverse
deb-src http://mirrors.163.com/ubuntu/ focal-security main restricted universe multiverse
deb-src http://mirrors.163.com/ubuntu/ focal-updates main restricted universe multiverse
deb-src http://mirrors.163.com/ubuntu/ focal-proposed main restricted universe multiverse
deb-src http://mirrors.163.com/ubuntu/ focal-backports main restricted universe multiverse
```

刷新列表

```sh
sudo apt update -y && sudo apt upgrade -y && sudo apt install build-essential -y
```


## 3.插件


1. 安装插件管理

```sh
# 安装以下可能需要科学上网
sudo apt install gnome-tweaks chrome-gnome-shell nome-shell-extension-manager -y
```
2. `gnome-tweaks`设置窗口居中打开,时间显示秒等（系统语言为中文的时候gnome-tweaks叫做优化）

3. 打开`Extension Manager`搜索安装对应插件
  - Blur my Shell

4. [extensions地址](https://extensions.gnome.org/)用chrome浏览器打开

## 4.驱动
显卡驱动要根据机器来装，Y7000P 2019 1650安装NVIDIA官方驱动之后有以下问题
- 触摸板三指手势失灵
- 屏幕亮度不可调节
在没有机器学期需求的前提下，最终决定不安装NVIDIA驱动，用默认驱动即可

## 4.常用软件
### 1.安装常用软件

```sh
sudo apt install neofetch tree  net-tools openssh-server git vim maven -y
```
### 2.vim配置
`vim /etc/vim/vimrc`追加

```sh
set nu
syntax on
set  ruler
set hlsearch
set ignorecase
set noswapfile
set undofile
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8
```

### 3.git配置

```sh
git config --global user.name  "your_account"
git config --global user.email "youremail@example.com"
# 生成ssh key(将公钥配置到GitHub&Gitee中)
ssh-keygen -o
# 解决中文乱码
git config --global core.quotepath false
```
### 4.安装docker
1. 一键安装
 ```sh
 # 官方脚本安装
 curl -fsSL https://get.docker.com | bash -s docker --mirror Aliyun
 ```
2. 设置开机启动
```
sudo systemctl enable docker
```

3. 免sudo运行

默认情况下，普通用户没有权限执行 docker 相关操作, 我们需要将普通用户加入到 docker 组

```sh
sudo usermod -aG docker [用户名]
docker info
```

然后退出 shell 重新登录，即可不使用 sudo 来运行 docker 相关操作

4. 镜像加速

使用阿里云免费镜像加速器：https://cr.console.aliyun.com/cn-hangzhou/instances/mirrors

### 5.安装Jdk
[清华镜像](https://mirrors.tuna.tsinghua.edu.cn/Adoptium/)

#### 常规配置

创建目录

```
sudo mkdir /usr/lib/jvm -p
```

上传压缩包解压到`/usr/lib/jvm`

```
 tar -zxvf OpenJDK8U-jdk_x64_linux_hotspot_8u322b06.tar.gz  -C /usr/lib/jvm
```
配置环境变量
```sh
vim /etc/profile
```
追加
```
export JAVA_HOME=/usr/lib/jvm/jdk8u322-b06
export PATH=$JAVA_HOME/bin:$PATH
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
```
刷新配置
```sh
source  /etc/profile
```
测试
```sh
java -version
```

#### Jdk多版本管理

`/etc/profile`中追加

```sh
Jdk8=/usr/lib/jvm/Jdk-8
Jdk17=/usr/lib/jvm/Jdk-17
# 设置所有用户的默认jdk版本
export JAVA_HOME=$Jdk17
export PATH=$JAVA_HOME/bin:$PATH
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar

# jvm 8 切换当前窗口jdk环境变量java8
function jvm {
    version=$1
    case "$version" in
    8)
        export JAVA_HOME=$Jdk8
        export PATH=$JAVA_HOME/bin:$PATH
        export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
        ;;
    17)
         export JAVA_HOME=$Jdk17
         export PATH=$JAVA_HOME/bin:$PATH
         export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
        ;;    
    *)
        echo "Please input 8 or 17"
        ;;

    esac
}
```

还有一种方法使用[jenv](https://www.jenv.be/)

### 6.图形化软件
 - idea
 - DataGrip 
 - vscode
 - edge 
 - chrome
 - postman
 - qq

### 7.配置Zsh
待完善




## 5.防火墙设置
```sh
#启动防火墙
sudo ufw enable
#关闭防火墙
sudo ufw disable
#防火墙状态
sudo ufw status
```
