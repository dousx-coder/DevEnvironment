### Ubuntu16.04升级 Ubuntu18.04

#### 1.更新资源

```sh
sudo apt-get update
sudo apt-get upgrade
sudo apt dist-upgrade
```

####  2.安装update-manager-core

```sh
sudo apt-get install  update-manager-core
```

####  3.更新16.04到18.04

```sh
sudo do-release-upgrade
```
执行上一步命令后，会自动升级系统。

####  4.清理无用的安装包

```sh
sudo apt-get remove
```

