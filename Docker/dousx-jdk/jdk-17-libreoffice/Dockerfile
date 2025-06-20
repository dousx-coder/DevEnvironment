FROM dousx/jdk:17

RUN apt-get update -y

RUN apt-get install libreoffice -y

# 清理缓存
RUN apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/*

# 默认命令或其他CMD指令
CMD ["echo", "built  by dousx"]

