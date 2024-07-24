# OhMyPosh 安装

> [terminalsplash 主题](https://terminalsplash.com/)

## 1.安装字体,下载 MESLO LGM NF 字体，解压，安装（给所有人）：

[https://ohmyposh.dev/docs/installation/fonts](https://ohmyposh.dev/docs/installation/fonts)

## 2.安装和配置 oh-my-posh

```powershell
# 安装oh-my-posh
winget install JanDeDobbeleer.OhMyPosh -s winget

# 使用的是哪个 shell
oh-my-posh get shell

# 直接加载：
& ([ScriptBlock]::Create((oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\jandedobbeleer.omp.json" --print) -join "`n"))

# 编辑PowerShell 配置文件脚本，每次启动之后自动加载
notepad $PROFILE

# 当上述命令出错时，请确保先创建配置文件
New-Item -Path $PROFILE -Type File -Force

# 在配置文件里添加以下行：
& ([ScriptBlock]::Create((oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\jandedobbeleer.omp.json" --print) -join "`n"))
或者添加这行：
oh-my-posh init pwsh --config '$env:POSH_THEMES_PATH\jandedobbeleer.omp.json' | Invoke-Expression

# 重新加载配置文件以使更改生效
. $PROFILE

# 查看所有themes:
Get-PoshThemes
#运行上面命令后，最后3行显示如下：
# ---theme存放的位置：
Themes location: C:\Users\admin\AppData\Local\Programs\oh-my-posh\themes
# --- 如果输入$profile, 得出的路径跟以下是一致的：
To change your theme, adjust the init script in C:\Users\admin\Documents\PowerShell\Microsoft.PowerShell_profile.ps1.
# --- 之前$profile配置文件，也可以改成以下这句（之前这句，向防病毒软件添加例外）
Example:
oh-my-posh init pwsh --config 'C:\Users\admin\AppData\Local\Programs\oh-my-posh\themes\jandedobbeleer.omp.json' | Invoke-Expression

# 安装文件图标库
Install-Module -Name Terminal-Icons -Repository PSGallery

#使用图标，可以把以下这条命令加到$PROFILE里（保存，.$profile使生效），单独运行就是一次性：
Import-Module -Name Terminal-Icons


#BONUS：
# 设置随机主题：
# 在powershell输入code $profile，输入下面的脚本命令：
$theme = Get-ChildItem $env:UserProfile\\AppData\\Local\\Programs\\oh-my-posh\\themes\\ | Get-Random
echo "hello! today's lucky theme is: $theme :)"
oh-my-posh --init --shell pwsh --config $theme.FullName | Invoke-Expression

```

**$PROFILE 配置**
配置

```powershell
Import-Module -Name Terminal-Icons
Import-Module posh-git

# 读取本地配置 加快加载速度
oh-my-posh init pwsh --config ~/oh-my-posh-themes/amro.omp.json | Invoke-Expression

# 使用历史记录进行脚本提示
Set-PSReadLineOption -PredictionSource History


# 设置 Ctrl+z 为撤销
Set-PSReadLineKeyHandler -Key "Ctrl+z" -Function Undo
# 编码问题
$OutputEncoding = [console]::InputEncoding = [console]::OutputEncoding = New-Object System.Text.UTF8Encoding
```

## 3.VSCODE 终端设置

> 字体: JetBrainsMono Nerd Font Mono

当你设置好上面的操作后，你的 VScode 也会有相应的变化，但如果不设置字体，也会出现主题显示也会有问题，在设置里将终端的字体样式也需要做相应的修改。`（注意是修改VScode终端的，不是VScode整体的字体）`,这样主题也能在 VScode 终端上完美显示。

**字体配置不对某些主题下的图标会展示错误**

**amro.omp.json 使用下图所示字体**

![image-20230310090607808](https://cruder-figure-bed.oss-cn-beijing.aliyuncs.com/markdown/2023/03/10/09-06-08-420.png)

**amro.omp.json 效果**

![image-20230310090646477](https://cruder-figure-bed.oss-cn-beijing.aliyuncs.com/markdown/2023/03/10/09-06-47-305.png)
