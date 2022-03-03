## Docker nexus 

> [官方链接](https://github.com/sonatype/docker-nexus3)

```shell
docker search nexus
docker pull sonatype/nexus3
docker run -d -p 8081:8081 --name nexus sonatype/nexus3
```

访问 http://ip:8081/