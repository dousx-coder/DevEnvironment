### Linux下安装Docker可视化工具LazyDocker

#### 下载安装包

```sh
wget https://github.com/jesseduffield/lazydocker/releases/download/v0.12/lazydocker_0.12_Linux_x86_64.tar.gz
```

#### 创建目录

```sh
mkdir -p /opt/lazydocker
```

#### 解压到指定目录

```
tar -zxvf lazydocker_0.12_Linux_x86_64.tar.gz -C /opt/lazydocker 
```

创建软链接

```
ln -s /opt/lazydocker/lazydocker lazydocker
```

移动到bin目录下

```sh
mv lazydocker /usr/local/bin
```

