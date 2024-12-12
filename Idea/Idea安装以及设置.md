# Idea 安装以及设置

## 1. 插件

- `CUBA`
- `Alibaba Java Coding Guidelines`
- `Jmix`
- `Rainbow Brackets`
- `Translation`
- `CodeGlance3`
- `Foldable ProjectView`

## 2.设置参数

`Help `-> `Edit Custom VM Options`

```properties
-Xms4096m
-Xmx8192m
-XX:+UseConcMarkSweepGC
-XX:ReservedCodeCacheSize=2048m
-Dfile.encoding=UTF-8
```

对应配置目录

- Windows `C:\Users\dousx\AppData\Roaming\JetBrains\IntelliJIdea20221\idea64.exe.vmoptions`

## 3.关联位置类型文件

> 使用系统关联的默认程序打开文件时，首先你的系统已经有默认的程序关联此文件的扩展名

![image-20220921105201279](https://cruder-figure-bed.oss-cn-beijing.aliyuncs.com/markdown/2022/09/21/10-52-01-538.png)

## 4.导入配色

导入`.icls`配色

![image-20220415211838821](https://cruder-figure-bed.oss-cn-beijing.aliyuncs.com/markdown/2022/04/15/09-18-39-114.png)

## 4.设置

### 4.1 注释不在行首

进入 Settings -> Code Style -> Java ，在右边选择 “Code Generation” Tab，然后找到 Comment Code 那块，
去掉`Line comment at first column`和`Block comment at first column`前面的复选框

![image-20220416194737517](https://cruder-figure-bed.oss-cn-beijing.aliyuncs.com/markdown/2022/04/16/07-47-37-832.png)

### 4.2 自动导包

![image-20220416194627247](https://cruder-figure-bed.oss-cn-beijing.aliyuncs.com/markdown/2022/04/16/07-46-27-476.png)

### 4.3 打开不自动加载项目

![image-20220416194810321](https://cruder-figure-bed.oss-cn-beijing.aliyuncs.com/markdown/2022/04/16/07-48-10-612.png)

### 4.4 关闭通过拖放移动代码片段

move code fragments with drag-and-drop

![image-20240514102742524](https://cruder-figure-bed.oss-cn-beijing.aliyuncs.com/markdown/2024/05/14/10-27-42-759.png)
### 4.5 ctrl 滚动缩放代码字体

![image-20240514102835426](https://cruder-figure-bed.oss-cn-beijing.aliyuncs.com/markdown/2024/05/14/10-28-35-656.png)

### 4.6 自定义快速模板

自带的模板有`psvm`、`sout`等

![image-20240516134153779](https://cruder-figure-bed.oss-cn-beijing.aliyuncs.com/markdown/2024/05/16/01-41-53-967.png)

**变量说明**

只有text中使用了变量，右侧的edit 按钮才能点击

```
// todo $user$ $date$ :
```

![image-20240620093514504](https://cruder-figure-bed.oss-cn-beijing.aliyuncs.com/markdown/2024/06/20/09-35-14-738.png)

## 5.忽略某些文件的显示

![image-20220415211519212](https://cruder-figure-bed.oss-cn-beijing.aliyuncs.com/markdown/2022/04/15/09-15-19-552.png)

## 6.编码配置

`.properties`如果出现中文乱码,设置`UTF-8`

![image-20220415211448738](https://cruder-figure-bed.oss-cn-beijing.aliyuncs.com/markdown/2022/04/15/09-14-49-045.png)

## 7.控制台缓存

> 控制台输出信息不全

![image-20220816103841547](https://cruder-figure-bed.oss-cn-beijing.aliyuncs.com/markdown/2022/08/16/10-38-44-855.png)

## 8.@Deprecated 删除线

![image-20230824092702180](https://cruder-figure-bed.oss-cn-beijing.aliyuncs.com/markdown/2023/08/24/09-27-02-522.png)

## 9. 使用系统默认程序打开文件

![image-20240704092406254](https://cruder-figure-bed.oss-cn-beijing.aliyuncs.com/markdown/2024/07/04/09-24-06-490.png)

## 10. 隐藏idea左侧项目路径

````properties
# custom IntelliJ IDEA properties
project.tree.structure.show.url=false
ide.tree.horizontal.default.autoscrolling=false
````

### 开启效果

![image-20241212093218644](https://cruder-figure-bed.oss-cn-beijing.aliyuncs.com/markdown/2024/12/12/09-32-18-828.png)

### 未隐藏效果(默认)

![image-20241212093322967](https://cruder-figure-bed.oss-cn-beijing.aliyuncs.com/markdown/2024/12/12/09-33-23-158.png)
