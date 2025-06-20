# Dockerfile-dev
FROM dousx/jdk:17-libreoffice

# https://github.com/opencv/opencv/tags 下载4.10.0zip
COPY dev-opencv-4.10.0.zip /opt/opencv-4.10.0.zip

RUN apt update && apt install -y \
    build-essential \
    cmake \
    ant \
    unzip \
    wget \
    g++ \
    pkg-config
# 解压
RUN cd /opt \
    && unzip opencv-4.10.0.zip  && cd opencv-4.10.0 && mkdir build && cd build

RUN cd /opt/opencv-4.10.0/build \
    && cmake -DBUILD_JAVA=ON \
    -DBUILD_opencv_java=ON \
    -DBUILD_JAVA_BINDINGS_GEN=ON \
    -DBUILD_PERF_TESTS=OFF \
    -DBUILD_TESTS=OFF \
    -DJava_JAVA_EXECUTABLE=/$JAVA_HOME/bin/java \
    -DJava_JAVAC_EXECUTABLE=/$JAVA_HOME/bin/javac \
    -DJava_INCLUDE_PATH=/$JAVA_HOME/include \
    -DJava_INCLUDE_PATH2=/$JAVA_HOME/include/linux \
    -DJava_AWT_LIBRARY=/$JAVA_HOME/lib/libawt.so \
    -DJava_JVM_LIBRARY=/$JAVA_HOME/lib/server/libjvm.so \
    -DCMAKE_INSTALL_PREFIX=/usr/local/opencv \
    .. \
    && make -j$(nproc) \
    && make install
# /opt/opencv-4.10.0/build/lib/libopencv_java4100.so
# 默认命令或其他CMD指令
CMD ["echo", "built  by dousx"]

