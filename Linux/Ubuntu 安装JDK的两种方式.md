# Ubuntu 安装JDK的两种方式

## 1.在线安装

> 在线安装通过`apt upgrade` 方式方便获得jdk的升级

###  1.1.安装

```sh
sudo apt update
# 安装11
sudo apt install openjdk-11-jdk -y
# 安装8
sudo apt install openjdk-8-jdk -y
```

###  1.2.查看当前Java版本

```sh
root@linux:~# java -version
openjdk version "1.8.0_292"
OpenJDK Runtime Environment (build 1.8.0_292-8u292-b10-0ubuntu1~20.04-b10)
OpenJDK 64-Bit Server VM (build 25.292-b10, mixed mode)
```
###  1.3.设置默认版本

```sh
root@linux:~# sudo update-alternatives --config java
There are 2 choices for the alternative java (providing /usr/bin/java).

  Selection    Path                                            Priority   Status
------------------------------------------------------------
* 0            /usr/lib/jvm/java-11-openjdk-amd64/bin/java      1111      auto mode
  1            /usr/lib/jvm/java-11-openjdk-amd64/bin/java      1111      manual mode
  2            /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java   1081      manual mode

Press <enter> to keep the current choice[*], or type selection number: 0
root@linux:~#
```

所有已经安装的 Java 版本将会列出来。输入你想要设置为默认值的序号，并且按"Enter”

然后修改环境变量

```sh
sudo vim /etc/environment
```

> 加上 JAVA_HOME="/usr/lib/jvm/java-11-openjdk-amd64"

```sh
# 刷新环境变量
source /etc/environment
```

> 此外，/etc/environment 设置的也是全局变量，从文件本身的作用上来说，/etc/environment 设置的是整个系统的环境，而/etc/profile是设置所有用户的环境。有几点需注意：
>
> - 登陆系统时shell读取的顺序应该是 
>          /etc/profile ->/etc/environment -->$HOME/.profile  -->$HOME/.env
> - /etc/environment中不能包含命令，即直接通过 VAR=”…” 的方式设置，不使用 export 。
> - 使用 source /etc/environment 可以使变量设置在当前窗口立即生效，需注销/重启之后，才能对每个新终端窗口都生效。
> - 如果所需环境变量 与 用户无关则直接设置/etc/environment即可。

/etc/profile 环境变量

```properties
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export JRE_HOME=${JAVA_HOME}/jre
export CLASSPATH=.:${JAVA_HOME}/lib:${JRE_HOME}/lib
export PATH=${JAVA_HOME}/bin:$PATH
```



###  1.4.卸载 Java

> 卸载11为例

查看包

```sh
 dpkg -l | grep openjdk*
```

 彻底删除（包括配置文件）

```sh
sudo apt purge openjdk-11* -y
```

验证

```sh
sudo update-alternatives --config java
```



## 2.通过官网下载安装包安装

[清华镜像](https://mirrors.tuna.tsinghua.edu.cn/Adoptium/)

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

