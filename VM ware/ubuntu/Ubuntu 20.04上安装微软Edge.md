**Ubuntu 20.04上安装微软Edge**

在Ubuntu 20.04上安装微软Edge浏览器是一个非常简单的过程，我们将从命令行启用Microsoft Edge存储库，并使用apt安装软件包。

1、通过以具有sudo特权的用户身份运行以下命令来更新程序包索引并安装依赖项：

```sh
sudo apt update -y

sudo apt install software-properties-common apt-transport-https wget -y
```

2、使用wget导入Microsoft GPG密钥：

```sh
wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
```

3、通过键入以下命令启用Edge浏览器存储库：

```sh
sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/edge stable main"
```

4、启用apt信息库后，安装Edge软件包：

```sh
sudo apt install microsoft-edge-dev -y
```

至此，您已经在Ubuntu 20.04系统上安装了微软Edge。