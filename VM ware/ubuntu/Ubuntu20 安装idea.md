## Ubuntu20 安装idea

下载tar.gz 解压

创建图标（所有的图标都在/usr/share/applications目录下）

```zsh
~ » sudo tar -zxvf ideaIC-2021.2.3.tar.gz -C /opt/idea
~ # vim /usr/share/applications/idea.desktop
~ # cat /usr/share/applications/idea.desktop
[Desktop Entry]
Name=IntelliJ IDEA
Comment=IntelliJ IDEA
Exec=/opt/idea/bin/idea.sh
Icon=/opt/idea/bin/idea.png
Terminal=false
Type=Application
Categories=Utility;Application
```