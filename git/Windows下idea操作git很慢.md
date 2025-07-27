### 1. 现象以及原因

微软电脑管家导致的

### 2. 解决办法

>解决办法有两个
>
>1. 找到安装路径彻底卸载电脑管家
>2. 禁用自启动

#### 1. 卸载微软电脑管家
注意事项如下：
   - 用geek看不到微软电脑管家
   - 设置里卸载并不彻底
   - 需要任务管理器中搜索manager，找到MSPCManagerService，在这里右键点击**打开文件所在位置**
   - 位置一般是：**C:\Program Files\WindowsApps\Microsoft.MicrosoftPCManager_3.17.4.0_x64__8wekyb3d8bbwe\PCManager**

![image-20250727150636745](https://cruder-figure-bed.oss-cn-beijing.aliyuncs.com/markdown/2025/07/27/03-06-37-019.png)

#### 2. 禁用微软电脑管家自启

   服务中找到**Microsoft PC Manager Service**禁止自启动

![image-20250727151435596](https://cruder-figure-bed.oss-cn-beijing.aliyuncs.com/markdown/2025/07/27/03-14-36-228.png)