FROM ringcentral/jdk:17

LABEL maintainer="dousx_cn@163.com"
LABEL author="dousx"
LABEL description="基于 ringcentral/jdk:17(ubuntu24.04cat /etc/os-release) 的自定义镜像，配置了时区、ping 和 vim"

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

# 清理缓存
RUN rm -rf /var/lib/apt/lists/*

# 默认命令或其他CMD指令
CMD ["echo", "built  by dousx"]