build.gradle 中添加下列配置，使 idea 自动下载依赖源码

```groovy
plugins {
    id 'idea'
}
idea {
  module {
    downloadSources = true
  }
}
```
