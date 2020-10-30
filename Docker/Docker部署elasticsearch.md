### Docker部署elasticsearch

#### 拉取镜像

``` 
docker pull elasticsearch:7.6.1
```

#### 运行容器

```shell
docker run --name es \
-p 9200:9200  \
-p 9300:9300   \
-e ES_JAVA_OPTS="-Xms1g -Xmx1g"  \
-d elasticsearch:7.6.1

# -e "discovery.type=single-node" 设置为单节点
# 特别注意：
# -e ES_JAVA_OPTS="-Xms1g -Xmx1g" \ 测试环境下，设置ES的初始内存和最大内存，否则导致过大启动不了ES
```

#### 安装ik分词器

```shell
# 进入容器 elasticsearch所在目录 /usr/share/elasticsearch
docker exec -it es /bin/bash

# 创建ik目录
mkdir /usr/share/elasticsearch/plugins/ik

# 将ik压缩包cp到容器内解压
docker cp elasticsearch-analysis-ik-7.6.1.zip es:/usr/share/elasticsearch/plugins/ik/

unzip elasticsearch-analysis-ik-7.6.1.zip 

rm -rf elasticsearch-analysis-ik-7.6.1.zip 

docker restart es
```

### 配置

```shell
# 将ik分词器配置导出
docker cp es:/usr/share/elasticsearch/plugins/ik/config/IKAnalyzer.cfg.xml /IKAnalyzer.cfg.xml
# 修改之后再次导入
docker cp /IKAnalyzer.cfg.xml es:/usr/share/elasticsearch/plugins/ik/config/IKAnalyzer.cfg.xml 
```

