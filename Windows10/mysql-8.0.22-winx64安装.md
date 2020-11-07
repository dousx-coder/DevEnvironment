### Windowns安装MySQL8

#### 下载解压MySQL8

>下载地址
>
>https://cdn.mysql.com//Downloads/MySQL-8.0/mysql-8.0.22-winx64.zip

#### 解压

>解压到自定义目录 在目录下创建my.ini文件以及data文件夹

##### my.ini内容

```ini
[mysqld]
# 设置3306端口
port=3306
# 设置mysql的安装目录
basedir=D:\\Program Files\mysql-8.0.22-winx64
# 设置mysql数据库的数据的存放目录
datadir=D:\\Program Files\mysql-8.0.22-winx64\\data
# 允许最大连接数
max_connections=200
# 允许连接失败的次数。这是为了防止有人从该主机试图攻击数据库系统
max_connect_errors=10
# 服务端使用的字符集默认为UTF8
character-set-server=utf8
# 创建新表时将使用的默认存储引擎
default-storage-engine=INNODB
[mysql]
# 设置mysql客户端默认字符集
default-character-set=utf8
[client]
# 设置mysql客户端连接服务端时默认使用的端口
port=3306
default-character-set=utf8
```

#### 配置环境变量

>![1604738115022](C:\Users\Dsx\AppData\Roaming\Typora\typora-user-images\1604738115022.png)

```shell
#同时在path下添加
%MYSQL_HOME%\bin
```

#### 初始化命令

>记住一定要进行初始化，很多人不进行初始化，就出现了1067错误，怎么弄都搞不定

```shell
# 以管理员的身份打开cmd窗口跳转路径到你的安装路径D:\\Program Files\mysql-8.0.22-winx64\\bin
mysqld --initialize --user=mysql --console
```

>会生成一个临时密码这里需要注意把临时密码记住
>
>![1604738365054](C:\Users\Dsx\AppData\Roaming\Typora\typora-user-images\1604738365054.png)

#### 服务添加和启动

```powershell
# 进行服务的添加
mysqld -install MySql80
# 启动服务
net start MySql80
```

#### 登录MySQL修改密码

```mysql
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'root';
FLUSH PRIVILEGES; 
```

