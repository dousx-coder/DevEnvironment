# PowerShell中Java乱码问题解决

![image-20220501195449771](https://cruder-figure-bed.oss-cn-beijing.aliyuncs.com/markdown/2022/05/01/07-54-50-159.png)

新增环境变量`JAVA_TOOL_OPTIONS = -Dfile.encoding=utf-8`,然后重新打开`PowerShell`

![image-20220501195557220](https://cruder-figure-bed.oss-cn-beijing.aliyuncs.com/markdown/2022/05/01/07-55-57-457.png)

提示`Picked up JAVA_TOOL_OPTIONS: -Dfile.encoding=utf-8`,说明设置成功

![image-20220501195703240](https://cruder-figure-bed.oss-cn-beijing.aliyuncs.com/markdown/2022/05/01/07-57-03-557.png)