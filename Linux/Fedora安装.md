# Fedora安装

>  机器 Y7000P 2019 1650
>
> [参考文档](https://docs.fedoraproject.org/zh_Hans/fedora/f32/install-guide/install/Preparing_for_Installation/)

## 1.制作启动盘

1. 下载[ISO](https://getfedora.org/en/workstation/download/)
2. 下载[制作工具](https://developers.redhat.com/blog/2016/04/26/fedora-media-writer-the-fastest-way-to-create-live-usb-boot-media)

## 配置源

https://mirrors.tuna.tsinghua.edu.cn/help/fedora/



## 插件

```sh
sudo dnf install gnome-tweak-tool -y
```

插件下载 https://extensions.gnome.org/

- Dash to Dock
- Hide Activity Button
- Blur my Shell 
- Compiz alike magic lamp effect
- Lock Keys
- Tray Icons: Reloaded
## 显卡驱动

> 过度动画更流畅
>
> x11没有三指手势 且亮度不能调节

1. 依赖

```sh
sudo dnf install kernel-devel kernel-headers gcc make dkms acpid libglvnd-glx libglvnd-opengl libglvnd-devel pkgconfig
```
2. 查找
```sh
sudo dnf search nvidia
```
3. 安装
```sh
sudo dnf install xorg-x11-drv-nvidia-470xx.x86_64  xorg-x11-drv-nvidia-470xx-cuda -y
```
4. 查找
```sh
 nvidia-smi
```
## 开启分数缩放
```sh
gsettings set org.gnome.mutter experimental-features "['scale-monitor-framebuffer']"
```

## vim配置
```sh
sudo vim /etc/vimrc
```
追加内容
```sh
set nu
syntax on
set  ruler
set hlsearch
set ignorecase
set noswapfile
set undofile
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8
```
## 卸载自带Jdk

```sh
rpm -qa|grep jdk
```

```sh
sudo rpm -e --nodeps java-17-openjdk-headless-17.0.6.0.10-1.fc37.x86_64
```