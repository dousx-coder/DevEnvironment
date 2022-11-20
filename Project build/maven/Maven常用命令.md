# Maven常用命令

打包
```
mvn package
```
编译

```
mvn compile
```

编译测试程序

```
mvn test-compile
```

清空

```
mvn clean
```

清空并打包

```
mvn clean package
```

运行测试

```
mvn test
```

生成站点目录

```
mvn site
```

生成站点目录并发布

```
mvn site-deploy
```

安装当前工程的输出文件到本地仓库

```
mvn install
```

 安 装指定文件到本地仓库

```
mvn install:install-file -DgroupId=<groupId> -DartifactId=<artifactId> -Dversion=1.0.0 -Dpackaging=jar -Dfile=<myfile.jar>
```

显示maven依赖树

```
mvn dependency:tree
```

显示maven依赖列表

```
mvn dependency:list
```

下载依赖包的源码

```
mvn dependency:sources
```

查看实际pom信息

```
mvn help:effective-pom
```

 分析项目的依赖信息

```
mvn dependency:analyze 或 mvn dependency:tree
```

跳过测试打包

```
mvn package '-Dmaven.test.skip=true'
```

生成eclipse项目文件

```
mvn eclipse:eclipse
```

查看帮助信息

```
mvn help:help 或 mvn help:help -Ddetail=true
```

查看插件的帮助信息

```
mvn <plug-in>:help，比如：mvn dependency:help 或 mvn ant:help 等等。
```

```
mvn -T 1C clean source:jar javadoc:javadoc install -Dmaven.test.skip=false -Dmaven.javadoc.skip=false
```