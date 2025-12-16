FROM ubuntu:24.04

LABEL maintainer="dousx_cn@163.com"
LABEL author="dousx"
LABEL description="基于 ubuntu:24.04(ubuntu24.04 cat /etc/os-release) 的自定义镜像，配置了jdk 时区、ping 和 vim"

# 指定编码 java.nio.file.InvalidPathException: Malformed input or input contains unmappable characters
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8
ENV JAVA_OPTS="-Dfile.encoding=UTF-8"

# 设置时区为上海
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# 设置aliyun镜像源    
RUN mv /etc/apt/sources.list.d/ubuntu.sources /etc/apt/sources.list.d/ubuntu.sources.bak    
# RUN echo 易引入隐藏格式错误，这里选用 COPY 预置文件
COPY aliyun.ubuntu.sources /etc/apt/sources.list.d/ubuntu.sources

RUN apt-get update -y
RUN apt-get upgrade -y 

RUN apt-get install -y vim   

RUN apt-get install -y iputils-ping

RUN apt-get install -y openjdk-17-jdk 

ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
ENV PATH=$PATH:$JAVA_HOME/bin
ENV JAVA_TOOL_OPTIONS="-Dfile.encoding=UTF-8"

# 验证安装
RUN java -version 

# 清理缓存
RUN apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/*

# 设置工作目录
WORKDIR /workspace


# 默认命令或其他CMD指令
CMD ["echo", "built  by dousx"]