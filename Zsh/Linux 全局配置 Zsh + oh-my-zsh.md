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
  sudo git clone https://github.com/robbyrussell/oh-my-zsh.git /etc/oh-my-zsh
  ```
  
- 从模板文件复制 .zshrc 创建默认配置文件（新用户将使用该配置文件）

  ```sh
  sudo  cp /etc/oh-my-zsh/templates/zshrc.zsh-template /etc/skel/.zshrc
  ```

- 第一行添加`source /etc/profile`,确保修改`/etc/profile`之后刷新`.zshrc`生效

  ```sh
  vim /etc/skel/.zshrc
  ```
  ```sh
  # .zshrc文件第一行添加
  source /etc/profile
  ```
- 修改 on-my-zsh 的安装目录 `export ZSH=$HOME/.oh-my-zsh` 为 `export ZSH=/etc/oh-my-zsh`

  ```sh
  sudo sed -i 's|$HOME/.oh-my-zsh|/etc/oh-my-zsh|g' /etc/skel/.zshrc
  ```

- 更改默认主题（推荐 ys/steeef/af-magic） https://github.com/ohmyzsh/ohmyzsh/wiki/Themes

  ```sh
  # 编辑 /etc/skel/.zshrc 文件修改
  sudo sed -i '/^ZSH_THEME=.*/c ZSH_THEME="steeef"' /etc/skel/.zshrc
  # 刷新配置
  source /etc/skel/.zshrc
  ```
  > 新用户登录后，将自动复制 .zshrc 和上述 cache 目录到用户主目录下，并自动加载 zsh 配置。

- 针对现有用户

  直接复制 /etc/skel/.zshrc 到 ~/

  ```sh
  # 执行之后 关闭当前窗口 重新连接
  sudo cp /etc/skel/.zshrc ~/.zshrc && mkdir -p ~/.oh-my-zsh/cache && source ~/.zshrc
  # 
  # <username> 替换为实际用户名
  sudo chsh -s /bin/zsh <username>
  ```

## 全局配置插件

> *全局安装插件（安装到 /etc/oh-my-zsh/custom/plugins/）*

- **zsh-autosuggestions：作用是根据历史输入命令的记录即时的提示，然后按键盘 → 即可补全。**

  ```sh
  sudo git clone https://github.com/zsh-users/zsh-autosuggestions.git /etc/oh-my-zsh/custom/plugins/zsh-autosuggestions
  ```

  编辑` /etc/skel/.zshrc`，找到 plugins=(git) 这一行，修改为：plugins=(git zsh-autosuggestions)

- **zsh-syntax-highlighting：语法高亮插件。作用：命令错误会显示红色，直到你输入正确才会变绿色，另外路径正确会显示下划线。**

  ```sh
  sudo  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git /etc/oh-my-zsh/custom/plugins/zsh-syntax-highlighting
  ```

  配置启用插件：
  编辑` /etc/skel/.zshrc`

  以下部分加入插件的名字
  plugins=([plugins…] zsh-syntax-highlighting)



## `.zshrc`配置示例

```sh
source /etc/profile
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/etc/oh-my-zsh

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="af-magic"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

```



