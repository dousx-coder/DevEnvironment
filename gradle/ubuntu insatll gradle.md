## Ubuntu 20.4 安装gradle

```sh
mkdir -p /opt/gradle
VERSION=7.2
wget https://services.gradle.org/distributions/gradle-${VERSION}-bin.zip
sudo unzip -d /opt/gradle gradle-7.2-bin.zip 
cd /opt/gradle/gradle-7.2/
sudo ln -s /opt/gradle/gradle-7.2 /opt/gradle/latest
sudo vim /etc/profile.d/gradle.sh
```
###  gradle.sh脚本中，加入如下两行
```sh
export GRADLE_HOME=/opt/gradle/gradle-7.2
export PATH=${GRADLE_HOME}/bin:${PATH}
```
###  增加脚本执行权限
```sh
sudo chmod +x /etc/profile.d/gradle.sh
source /etc/profile.d/gradle.sh
```
###  验证安装是否成功
```sh
gradle -v                                                                                      
------------------------------------------------------------
Gradle 7.2
------------------------------------------------------------

Build time:   2021-08-17 09:59:03 UTC
Revision:     a773786b58bb28710e3dc96c4d1a7063628952ad

Kotlin:       1.5.21
Groovy:       3.0.8
Ant:          Apache Ant(TM) version 1.10.9 compiled on September 27 2020
JVM:          1.8.0_292 (Private Build 25.292-b10)
OS:           Linux 5.4.0-90-generic amd64
```



