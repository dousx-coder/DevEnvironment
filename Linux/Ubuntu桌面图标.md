# Ubuntu桌面图标
## 创建图标
- 目录`/usr/share/applications`中增加`navicat15.desktop`

- 内容如下

```sh
[Desktop Entry]
Type=Application
Name=Navicat Premium 15
#Name=App Run
GenericName=Database Development Tool
Icon=/usr/local/software/navicat15/navicat-icon.png
Exec=/usr/local/software/navicat15/navicat15.AppImage
Categories=Development;
Keywords=database;sql;
StartupWMClass=AppRun
```

## 消除侧边栏出现两个图标

1. 启动应用
2. 在terminate中执行`xprop |grep WM_CLASS`，此时鼠标会变成一个十字的准星。此时点击已经打开的`Navicat`界面命令行会显示 `WM_CLASS(STRING) = "AppRun", "AppRun"`
3. 然后在`navicat15.desktop`后面添加一行：`StartupWMClass=AppRun`