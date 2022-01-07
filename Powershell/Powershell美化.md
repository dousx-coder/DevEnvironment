# Powershell美化

## 1.安装Powershell

https://hub.fastgit.org/PowerShell/PowerShell/releases/latest

## 2.安装Git

https://hub.fastgit.org/git-for-windows/git/releases/latest

## 3.安装字体

https://www.jetbrains.com/lp/mono/

```powershell
# 下载安装字体,解决vscode字体问题
git clone https://github.com/abertsch/Menlo-for-Powerline.git
```

## 4.安装Windows Terminal 

## 5.安装终端主题

```powershell
Install-Module posh-git
Install-Module oh-my-posh
```

设置 PowerShell 的`初始化`文件

```powershell
if (!(Test-Path -Path $PROFILE )) { New-Item -Type File -Path $PROFILE -Force }
notepad $PROFILE
```

> notepad $PROFILE 可以打开配置文件编辑

粘贴下面到配置文件中

```
Import-Module posh-git
Import-Module oh-my-posh
Set-PoshPrompt ys
```

![image-20220107142343530](https://cruder-figure-bed.oss-cn-beijing.aliyuncs.com/markdown/2022/01/07/02-23-43-728.png)

## 6.解决vscode字体展示问题

```powershell
# 下载安装字体,解决vscode字体问题
git clone https://github.com/abertsch/Menlo-for-Powerline.git
```

安装字体，然后设置vscode 终端字体`Menlo for Powerline` 字体大小设置`13`

![image-20220107141710177](https://cruder-figure-bed.oss-cn-beijing.aliyuncs.com/markdown/2022/01/07/02-17-10-443.png)
