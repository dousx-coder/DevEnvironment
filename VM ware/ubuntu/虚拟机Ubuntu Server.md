![image-20221121204550876](https://cruder-figure-bed.oss-cn-beijing.aliyuncs.com/markdown/2022/11/21/08-45-51-185.png)





![image-20221121204614998](https://cruder-figure-bed.oss-cn-beijing.aliyuncs.com/markdown/2022/11/21/08-46-15-264.png)



![image-20221121204629378](https://cruder-figure-bed.oss-cn-beijing.aliyuncs.com/markdown/2022/11/21/08-46-29-652.png)





![image-20221121204831653](https://cruder-figure-bed.oss-cn-beijing.aliyuncs.com/markdown/2022/11/21/08-48-31-915.png)





![image-20221121204849357](https://cruder-figure-bed.oss-cn-beijing.aliyuncs.com/markdown/2022/11/21/08-48-49-638.png)





![image-20221121205001297](https://cruder-figure-bed.oss-cn-beijing.aliyuncs.com/markdown/2022/11/21/08-50-01-569.png)





![image-20221121205021882](https://cruder-figure-bed.oss-cn-beijing.aliyuncs.com/markdown/2022/11/21/08-50-22-168.png)





![image-20221121205837942](https://cruder-figure-bed.oss-cn-beijing.aliyuncs.com/markdown/2022/11/21/08-58-38-140.png)



`A start job is running for wait for network to be Configured`

`cd /etc/systemd/system/network-online.target.wants/`

`sudo vi systemd-networkd-wait-online.service`

在[Service]下添加`TimeoutStartSec=2sec`

