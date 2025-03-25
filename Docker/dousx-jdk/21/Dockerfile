# 使用 ringcentral/jdk 作为基础镜像
FROM ringcentral/jdk:21

LABEL maintainer="dousx_cn@163.com"
LABEL author="dousx"
LABEL description="基于 ringcentral/jdk:21 的自定义镜像，配置了时区、ping 和 vim"

# 设置时区为上海（可根据需要调整）
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# 安装 vim 编辑器
# 假设是基于 Debian 或 Ubuntu 的镜像
RUN apt-get update && \
    apt-get install -y vim && \
    rm -rf /var/lib/apt/lists/*

# 安装 ping 工具
# 同样地，假设是基于 Debian 或 Ubuntu 的镜像
RUN apt-get update && \
    apt-get install -y iputils-ping && \
    rm -rf /var/lib/apt/lists/*



# 可以在这里添加更多所需的配置或软件包


# 默认命令或其他CMD指令（可选）
CMD ["echo", "built  by dousx"]