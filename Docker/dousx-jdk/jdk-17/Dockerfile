FROM ubuntu:24.04

LABEL maintainer="dousx_cn@163.com"
LABEL author="dousx"
LABEL description="基于 ubuntu:24.04(ubuntu24.04 cat /etc/os-release) 的自定义镜像，配置了jdk 时区、ping 和 vim"

# 设置时区为上海
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# 设置aliyun镜像源    
RUN mv /etc/apt/sources.list.d/ubuntu.sources /etc/apt/sources.list.d/ubuntu.sources.bak    
# RUN echo 易引入隐藏格式错误，这里选用 COPY 预置文件
COPY aliyun.ubuntu.sources /etc/apt/sources.list.d/ubuntu.sources

RUN apt-get update -y
RUN apt-get upgrade -y 
RUN apt-get autoremove -y

# 安装 vim 编辑器
RUN apt-get install -y vim     
RUN apt-get install -y iputils-ping



# ------------ JDK 17 配置 ------------
# https://download.oracle.com/java/17/latest/jdk-17_linux-x64_bin.tar.gz下载到宿主机，copy到镜像
# oracle似乎有限制,wget下载似乎会失败
COPY jdk-17_linux-x64_bin.tar.gz /tmp/
# 解压并安装 JDK
RUN mkdir -p /usr/local/java && \
    tar -xzf /tmp/jdk-17_linux-x64_bin.tar.gz -C /usr/local/java --strip-components=1 && \
    rm /tmp/jdk-17_linux-x64_bin.tar.gz

# 安装 JDK 17（手动下载解压，避免镜像膨胀）
# RUN mkdir -p /usr/local/java && \
#     wget -qO jdk17.tar.gz https://download.oracle.com/java/17/latest/jdk-17_linux-x64_bin.tar.gz && \
#     tar -xzf jdk17.tar.gz -C /usr/local/java --strip-components=1 && \
#     rm jdk17.tar.gz

# 设置 Java 环境变量
ENV JAVA_HOME=/usr/local/java
ENV PATH=$JAVA_HOME/bin:$PATH

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