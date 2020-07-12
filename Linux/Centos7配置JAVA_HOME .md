**A 定位JDK安装路径**

1. 终端输入：

```shell
which java
```

输出为：

```shell
/usr/bin/java
```

2. 终端输入：

```shell
ls -lr /usr/bin/java
```

输出为：

/usr/bin/java -> 

3. 终端输入

```shell
ls -lrt /etc/alternatives/java
```

输出：

 /etc/alternatives/java -> /usr/lib/jvm/java-1.8.0-openjdk-1.8.0.252.b09-2.el7_8.x86_64/jre/bin/java

至此，我们确定java的安装目录为： /usr/lib/jvm/java-1.8.0-openjdk-1.8.0.252.b09-2.el7_8.x86_64

 

**B 配置JAVA_HOME**

1. 打开配置环境变量的文件

```
vim /etc/profile
```

2. 添加以下配置：

```shell
export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.252.b09-2.el7_8.x86_64
export JRE_HOME=$JAVA_HOME/jre
export CLASSPATH=$JAVA_HOME/lib:$JRE_HOME/lib:$CLASSPATH
export PATH=$JAVA_HOME/bin:$JRE_HOME/bin:$PATH
```

:wq保存退出。

3. 让配置生效

```shell
source  /etc/profile
```

4. 测试配置结果

```shell
echo $JAVA_HOME
```

   5.安装java-devel

```shell
 yum -y install java-devel
```

