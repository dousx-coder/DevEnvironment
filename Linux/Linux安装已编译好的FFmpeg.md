# Linux安装已编译好的FFmpeg

1. [FFmpeg Static Builds](https://johnvansickle.com/ffmpeg/)

2. [下载地址](https://johnvansickle.com/ffmpeg/releases/ffmpeg-release-amd64-static.tar.xz)
3. `wget https://johnvansickle.com/ffmpeg/releases/ffmpeg-release-amd64-static.tar.xz`

4. 解压到指定目录`sudo tar -xvJf ffmpeg-release-amd64-static.tar.xz -C /usr/local/ `

5. 配置环境变量`sudo vim /etc/profile`追加`export PATH=$PATH:/usr/local/ffmpeg-5.0.1-amd64-static`

6. `source /etc/profile`

7. `ffmpeg -version`

   