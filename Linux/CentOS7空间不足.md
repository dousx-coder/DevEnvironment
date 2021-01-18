提示/var空间不足。
解决办法：使用软链接指向空间大的区域。
例如/home分配的最大，然后var下的cache目录比较大，就将cache移动到/home下。
Linux软链接：在指定的位置上生成一个镜像文件。

先将cache移动到home下，再将/var/cache指向/home/cache，cache就不占用var的空间了。

```sh
[root@localhost /]#mv /var/cache /home
[root@localhost /]#ln -s /home/cache /var
```