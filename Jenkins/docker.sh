#!/bin/bash
#maven打包
mvn clean package
echo 'package ok!'
echo 'build start!'
cd ./
service_name="demo-jenkins"
service_prot=8080
#查看镜像id
IID=$(docker images | grep "$service_name" | awk '{print $3}')
echo "IID $IID"
if [ -n "$IID" ]
then
    echo "exist $SERVER_NAME image,IID=$IID"
    #删除镜像
    docker rmi -f $service_name
    echo "delete $SERVER_NAME image"
    #构建
    docker build -t $service_name .
    echo "build $SERVER_NAME image"
else
    echo "no exist $SERVER_NAME image,build docker"
    #构建
    docker build -t $service_name .
    echo "build $SERVER_NAME image"
fi
#查看容器id
CID=$(docker ps | grep "$SERVER_NAME" | awk '{print $1}')
echo "CID $CID"
if [ -n "$CID" ]
then
    echo "exist $SERVER_NAME container,CID=$CID"
    #停止
    docker stop $service_name
    #删除容器
    docker rm $service_name
else
    echo "no exist $SERVER_NAME container"
fi
#启动
docker run -d --name $service_name --net=host -p $service_prot:$service_prot $service_name
#查看启动日志
#docker logs -f  $service_name