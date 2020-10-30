### Docker部署elasticsearch

#### 拉取镜像

``` 
docker pull elasticsearch:7.6.1
```

#### 创建挂载的目录

```
mkdir -p /docker_data/elasticsearch/config
mkdir -p /docker_data/elasticsearch/data
echo "http.host: 0.0.0.0" >> /docker_data/elasticsearch/config/elasticsearch.yml
```

#### 运行容器

```shell
docker run --name es \
-p 9200:9200  \
-p 9300:9300   \
-e ES_JAVA_OPTS="-Xms1g -Xmx1g"  \
-v /docker_data/elasticsearch/config/elasticsearch.yml:/usr/share/elasticsearch/config/elasticsearch.yml  \
-v /docker_data/elasticsearch/data:/usr/share/elasticsearch/data  \
-v /docker_data/elasticsearch/plugins:/usr/share/elasticsearch/plugins  \
-d elasticsearch:7.6.1

# 其中elasticsearch.yml是挂载的配置文件，data是挂载的数据，plugins是es的插件，如ik，而数据挂载需要权限，需要设置data文件的权限为可读可写,需要下边的指令。
# chmod -R 777 要修改的路径
# -e "discovery.type=single-node" 设置为单节点
# 特别注意：
# -e ES_JAVA_OPTS="-Xms1g -Xmx1g" \ 测试环境下，设置ES的初始内存和最大内存，否则导致过大启动不了ES
```

#### 安装ik分词器

```shell
# 进入容器
docker exec -it es /bin/bash

# 创建ik目录
mkdir /usr/share/elasticsearch/plugins/ik

# 将ik压缩包cp到容器内解压
docker cp elasticsearch-analysis-ik-6.7.1.zip es:/usr/share/elasticsearch/plugins/ik/

unzip elasticsearch-analysis-ik-6.7.1.zip 

rm -rf elasticsearch-analysis-ik-6.7.1.zip 

docker restart es
```



