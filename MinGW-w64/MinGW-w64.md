# 在windows上安装MinGW-w64
[Mingw-w64是原始 mingw.org 项目的进步，旨在 在Windows系统上支持GCC编译器](https://www.mingw-w64.org/)
## 安装方式
- 下载压缩包安装**(推荐)**
- 使用MinGW-w64下载器安装

## 压缩包安装
**压缩包安装文件命名方式解释**
- version: GCC编译器版本
- architecture: 电脑系统类型，i686指32位系统；x86_64指64位系统
- threads: 线程类型，posix指可移植的操作系统接口，UNIX系统支持该标准；win32指windows下的一个标准
- exception: 异常处理类型，32位系统有2种：dwarf和sjlj；64位系统同样2种：seh 和 sjlj。3种类型的区别为[^2]：
- sjlj：可用于32位和64位 – 不是“零成本”：即使不抛出exception，也会造成较小的性能损失（在exception大的代码中约为15％） – 允许exception遍历例如窗口callback
- seh：结构化异常处理，利用FS段寄存器，将原点压入栈，遇到异常弹出，seh 是新发明的，而 sjlj 则是古老的，seh 性能比较好，但不支持 32位。 sjlj 稳定性好，支持 32位
dwarf：只有32位可用 – 没有永久的运行时间开销 – 需要整个调用堆栈被启用，这意味着exception不能被抛出，例如Windows系统DLL。
- build revision: 建立修订
1. [下载](https://sourceforge.net/projects/mingw-w64/files/mingw-w64/)
2. 解压到指定目录
3. 配置环境变量
   - `mingw64/bin`配置到系统环境变量PATH中
4. ` gcc -v`验证


[参考](https://shaogui.life/2021/03/10/windows%E4%B8%8A%E5%AE%89%E8%A3%85minGW/#filename_rule)