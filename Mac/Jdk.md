# Jdk安装

## Mac
[zulu Jdk](https://www.azul.com/downloads/?version=java-8-lts&os=macos&architecture=arm-64-bit&package=jdk&show-old-builds=true#zulu)
1. 下载压缩包解压 移动到下面目录 
2. `vim ~/.zshrc`添加下面内容 动态修改jdk
```sh
# JDK 8、JDK 17 21的 export 命令
export JDK8_HOME="/Library/Java/JavaVirtualMachines/zulu-8.jdk/Contents/Home"
export JDK17_HOME="/Library/Java/JavaVirtualMachines/jdk-17.jdk/Contents/Home"
export JDK21_HOME="/Library/Java/JavaVirtualMachines/jdk-21.jdk/Contents/Home"
 
# alias 命令链接到 export 命令
alias jdk8="export JAVA_HOME=$JDK8_HOME"
alias jdk17="export JAVA_HOME=$JDK17_HOME"
alias jdk21="export JAVA_HOME=$JDK21_HOME"
```