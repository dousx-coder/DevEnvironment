# 命令行中修改 jdk 环境变量

- [参考](https://zhuanlan.zhihu.com/p/611832551)
- [issues17](https://github.com/neolee/pilot/issues/17)

```ps
 code $PROFILE
```

添加

```ps
function Java8{
    $JAVA_HOME_8 = [System.Environment]::GetEnvironmentVariable('JAVA_HOME_8','Machine')
    Write-Host $JAVA_HOME_8
    [System.Environment]::SetEnvironmentVariable('JAVA_HOME',$JAVA_HOME_8,'Machine')
}

function Java17{
    $JAVA_HOME_17 = [System.Environment]::GetEnvironmentVariable('JAVA_HOME_17','Machine')
    Write-Host $JAVA_HOME_17
    [System.Environment]::SetEnvironmentVariable('JAVA_HOME',$JAVA_HOME_17,'Machine')
}

Set-Alias jvm8 JAVA8
Set-Alias jvm17 JAVA17
```

**待解决**

```ps
 dousx on  ~
# jvm8
C:\Develop\Jdk\8
ParentContainsErrorRecordException: C:\Users\dousx\Documents\PowerShell\Microsoft.PowerShell_profile.ps1:21
Line |
  21 |      [System.Environment]::SetEnvironmentVariable('JAVA_HOME',$JAVA_HO …
     |      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     | Exception calling "SetEnvironmentVariable" with "3" argument(s): "Requested registry access is not allowed."
```

**需要管理员打开终端执行命令才生效，且生效之后没有立刻刷新环境变量**
后面抽空研究如何立刻刷新当前命令窗口环境
