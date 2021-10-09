# Linux 全局配置 Zsh + oh-my-zsh

## 准备 zsh

- 查看当前 shell
  ```sh
  echo $SHELL
  ```
 - 安装 zsh

   ```sh
   sudo apt install zsh -y
   ```
- 为 root 设置默认 shell

  ```sh
  sudo chsh -s /bin/zsh
  ```
- 为特定用户设置默认 shell

  ```sh
  # <username> 替换为实际用户名
  sudo chsh -s /bin/zsh <username>
  ```
## 全局配置 zsh

  >*注意：以下全局配置相关命令需要 root 权限，请切换到 root 账号，或者使用 sudo。*

- 全局安装 zsh 到 /etc 目录

  ```sh
  git clone https://github.com/robbyrussell/oh-my-zsh.git /etc/oh-my-zsh
  ```
  
- 从模板文件复制 .zshrc 创建默认配置文件（新用户将使用该配置文件）

  ```sh
  cp /etc/oh-my-zsh/templates/zshrc.zsh-template /etc/skel/.zshrc
  ```

- 修改 on-my-zsh 的安装目录 `export ZSH=$HOME/.oh-my-zsh` 为 `export ZSH=/etc/oh-my-zsh`

  ```sh
  sed -i 's|$HOME/.oh-my-zsh|/etc/oh-my-zsh|g' /etc/skel/.zshrc
  ```

- 更改默认主题（推荐 ys） https://github.com/ohmyzsh/ohmyzsh/wiki/Themes

  ```sh
  # 编辑 /etc/skel/.zshrc 文件修改
  sed -i '/^ZSH_THEME=.*/c ZSH_THEME="ys"' /etc/skel/.zshrc
  # 刷新配置
  source /etc/skel/.zshrc
  ```
  > 新用户登录后，将自动复制 .zshrc 和上述 cache 目录到用户主目录下，并自动加载 zsh 配置。

- 针对现有用户

    直接复制 /etc/skel/.zshrc 到 ~/

  ```sh
  cp /etc/skel/.zshrc ~/.zshrc
  mkdir -p ~/.oh-my-zsh/cache
  source ~/.zshrc
  ```

## 全局配置插件

> *全局安装插件（安装到 /etc/oh-my-zsh/custom/plugins/）*

- **zsh-autosuggestions：作用是根据历史输入命令的记录即时的提示，然后按键盘 → 即可补全。**

  ```sh
  git clone https://github.com/zsh-users/zsh-autosuggestions.git /etc/oh-my-zsh/custom/plugins/zsh-autosuggestions
  ```

  编辑 /etc/skel/.zshrc，找到 plugins=(git) 这一行，修改为：plugins=(git zsh-autosuggestions)

- **zsh-syntax-highlighting：语法高亮插件。作用：命令错误会显示红色，直到你输入正确才会变绿色，另外路径正确会显示下划线。**

  ```sh
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git /etc/oh-my-zsh/custom/plugins/zsh-syntax-highlighting
  ```

  配置启用插件：
  编辑 /etc/skel/.zshrc

  以下部分加入插件的名字
  plugins=([plugins…] zsh-syntax-highlighting)

