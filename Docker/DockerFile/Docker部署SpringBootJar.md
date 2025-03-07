### Docker 部署 SpringBootJar

> 将可执行 jar 包和 Dockerfile 放在同一目录

Dockerfile 内容如下

```dockerfile
# Dockerfile
FROM ringcentral/jdk:17
# 创建统一存放配置的目录
RUN mkdir -p /app/config
RUN chmod -R 755 /app/config

# 设置工作目录为 /app（后续操作默认在此目录下执行）
WORKDIR /app

ENV CONFIG_DIR=/app/config

COPY build/libs/boot-upload-download.jar /app/app.jar
COPY src/main/resources/application-docker.yml ${CONFIG_DIR}/
COPY src/main/resources/redisson-single-docker.yml ${CONFIG_DIR}/
COPY src/main/resources/logback-spring-docker.xml ${CONFIG_DIR}/

# 指定spring配置文件 spring.redis.redisson.file配置文件
CMD ["java", "-jar", "/app/app.jar",\
"--spring.config.location=file:${CONFIG_DIR}/application-docker.yml",\
"--spring.redis.redisson.file=file:${CONFIG_DIR}/redisson-single-docker.yml",\
"--logging.config=file:${CONFIG_DIR}/logback-spring-docker.xml"]
```

### 执行命令

```shell
docker build -t bud:0.1 .
```

### 创建容器

````shell
docker run -d -p 17100:17100 --name=bud bud:0.1
```

[示例项目](https://github.com/dousx-coder/boot-upload-download)
````
