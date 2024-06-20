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

`dousx_custom.icls`内容如下:

```xml
<scheme name="dousx-custom" version="142" parent_scheme="Darcula">
  <metaInfo>
    <property name="created">2022-04-14T22:06:33</property>
    <property name="ide">Idea</property>
    <property name="ideVersion">2022.1.0.0</property>
    <property name="modified">2022-04-14T22:06:38</property>
    <property name="originalScheme">dousx-custom</property>
  </metaInfo>
  <attributes>
    <option name="ABSTRACT_CLASS_NAME_ATTRIBUTES">
      <value>
        <option name="FOREGROUND" value="39cb0" />
      </value>
    </option>
    <option name="ANNOTATION_NAME_ATTRIBUTES">
      <value>
        <option name="FOREGROUND" value="39c8b0" />
        <option name="EFFECT_TYPE" value="1" />
      </value>
    </option>
    <option name="ANONYMOUS_CLASS_NAME_ATTRIBUTES">
      <value>
        <option name="FOREGROUND" value="39c8b0" />
      </value>
    </option>
    <option name="CLASS_NAME_ATTRIBUTES">
      <value>
        <option name="FOREGROUND" value="39c8b0" />
      </value>
    </option>
    <option name="CONSTRUCTOR_CALL_ATTRIBUTES">
      <value>
        <option name="FOREGROUND" value="1cb7db" />
      </value>
    </option>
    <option name="ENUM_NAME_ATTRIBUTES">
      <value>
        <option name="FOREGROUND" value="39c8b0" />
      </value>
    </option>
    <option name="HTML_CODE">
      <value />
    </option>
    <option name="INHERITED_METHOD_ATTRIBUTES">
      <value>
        <option name="FOREGROUND" value="6b73de" />
      </value>
    </option>
    <option name="INTERFACE_NAME_ATTRIBUTES">
      <value>
        <option name="FOREGROUND" value="3d8f7f" />
      </value>
    </option>
    <option name="JAVA_NUMBER">
      <value>
        <option name="FOREGROUND" value="6897bb" />
      </value>
    </option>
    <option name="KOTLIN_LABEL">
      <value />
    </option>
    <option name="LOCAL_VARIABLE_ATTRIBUTES">
      <value />
    </option>
    <option name="MATCHED_BRACE_ATTRIBUTES">
      <value>
        <option name="BACKGROUND" value="3b514d" />
        <option name="FONT_TYPE" value="1" />
      </value>
    </option>
    <option name="METHOD_CALL_ATTRIBUTES">
      <value>
        <option name="FOREGROUND" value="787bb4" />
      </value>
    </option>
    <option name="PARAMETER_ATTRIBUTES">
      <value>
        <option name="FOREGROUND" value="499cd5" />
      </value>
    </option>
    <option name="REASSIGNED_LOCAL_VARIABLE_ATTRIBUTES">
      <value>
        <option name="EFFECT_COLOR" value="707d95" />
        <option name="EFFECT_TYPE" value="1" />
      </value>
    </option>
    <option name="STATIC_FIELD_ATTRIBUTES">
      <value>
        <option name="FOREGROUND" value="ffc66d" />
        <option name="FONT_TYPE" value="2" />
      </value>
    </option>
    <option name="STATIC_FINAL_FIELD_ATTRIBUTES">
      <value>
        <option name="FOREGROUND" value="ffc66d" />
        <option name="FONT_TYPE" value="2" />
      </value>
    </option>
    <option name="STATIC_METHOD_ATTRIBUTES">
      <value>
        <option name="FOREGROUND" value="a0a53d" />
        <option name="FONT_TYPE" value="2" />
      </value>
    </option>
  </attributes>
</scheme>
```

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
