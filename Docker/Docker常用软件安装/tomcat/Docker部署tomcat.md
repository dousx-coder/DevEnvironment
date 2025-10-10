# Docker 部署 tomcat

## 1. 部署

```shell
docker run -d -p 18080:8080 --name tomcat tomcat:9.0.87-jdk8-corretto-al2
```

## 2.修改 webapps

```shell
cd /usr/local/tomcat/
```

```shell
rm webapps -r
```

```shell
mv webapps.dist/ webapps
```
