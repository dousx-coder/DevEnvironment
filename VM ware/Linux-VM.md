# Linux vmware

[VM-17下载链接](https://download3.vmware.com/software/WKST-1700-LX/VMware-Workstation-Full-17.0.0-20800274.x86_64.bundle)
## 安装
1. 添加执行权限
```sh
sudo chmod a+x VMware-Workstation-Full-17.0.0-20800274.x86_64.bundle 
```
2. 安装
```sh
sudo ./VMware-Workstation-Full-17.0.0-20800274.x86_64.bundle
```

3. 安装成功之后会有一些`vmware-`开头的命令可用，例如
```sh
# dousx @ fedora in ~/Downloads [17:29:39] 
$ vmware-installer -l
Product Name         Product Version     
==================== ====================
vmware-workstation   17.0.0.20800274  
```

## 桌面图标
> 固定快捷栏启动虚拟机会有两个图标
```sh
# dousx @ fedora in /usr/share/applications [17:31:36] 
$ ll vmware-*               
-rw-r--r--. 1 root root 208  2月12日 17:21 vmware-netcfg.desktop
-rw-r--r--. 1 root root 279  2月12日 17:21 vmware-player.desktop
-rw-r--r--. 1 root root 323  2月12日 17:21 vmware-workstation.desktop
```
1. 启动应用
在terminate中执行`xprop |grep WM_CLASS`，此时鼠标会变成一个`十字准星`。此时用`十字准星`点击已经打开的`vmware-workstation`界面命令行会显示 `WM_CLASS(STRING) = "vmware", "Vmware"`
如下
```sh
# dousx @ fedora in /usr/share/applications [17:34:21] 
$ xprop |grep WM_CLASS 
WM_CLASS(STRING) = "vmware", "Vmware"
```
2. 在`vmware-workstation.desktop`后面添加一行：`StartupWMClass=Vmware`