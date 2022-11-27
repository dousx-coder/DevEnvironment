# [Oh My Posh](https://ohmyposh.dev/docs)

1. `winget install JanDeDobbeleer.OhMyPosh -s winget`
2. [安装字体](https://ohmyposh.dev/docs/installation/fonts)
3. `notepad $PROFILE`

- `$PROFILE`内容如下
```
Import-Module posh-git

# oh-my-posh init pwsh | Invoke-Expression
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/lambda.omp.json" | Invoke-Expression

# 使用历史记录进行脚本提示
Set-PSReadLineOption -PredictionSource History
# 编码问题
$OutputEncoding = [console]::InputEncoding = [console]::OutputEncoding = New-Object System.Text.UTF8Encoding

```

3. `. $PROFILE`
