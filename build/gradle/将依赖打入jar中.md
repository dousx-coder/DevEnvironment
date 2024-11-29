# 依赖打包到 jar 中

## 配置说明

`plugins`增加`id 'com.github.johnrengelman.shadow' version '7.1.2'`

`build.gradle`中增加

```groovy
shadowJar {
    // 设置 JAR 基础名称
    archiveBaseName.set('fct')
    // 添加 `-all` 后缀，表示包含依赖
    archiveClassifier.set('all')
    // 版本号
//    archiveVersion.set(version)
}
```

## 打包命令

```sh
gradle clean shadowJar
```

## 配置示例

`build.gradle`配置示例

```groovy
plugins {
    id 'java-library'
    id 'maven-publish'
    id 'com.github.johnrengelman.shadow' version '7.1.2'
}

group = 'com.tcx'
version = '1.1.2024-11-29.15'

shadowJar {
    // 设置 JAR 基础名称
    archiveBaseName.set('fct')
    // 添加 `-all` 后缀，表示包含依赖
    archiveClassifier.set('all')
    // 版本号
//    archiveVersion.set(version)
}
tasks.withType(JavaExec) {
    jvmArgs = ['-Dfile.encoding=UTF-8']
}
repositories {
    mavenLocal()

    mavenCentral()
}

dependencies {
    testImplementation 'org.junit.jupiter:junit-jupiter-api:5.9.0'
    testRuntimeOnly 'org.junit.jupiter:junit-jupiter-engine:5.9.0'
    implementation 'com.itextpdf:itextpdf:5.5.13.3'
    implementation 'org.apache.pdfbox:pdfbox:2.0.28'
    implementation 'org.bouncycastle:bcprov-jdk15on:1.69'
    implementation 'org.bouncycastle:bcpkix-jdk15on:1.69'
    implementation 'commons-io:commons-io:2.5'
    implementation 'ch.qos.logback:logback-core:1.2.9'
    implementation 'ch.qos.logback:logback-access:1.2.9'
    implementation 'ch.qos.logback:logback-classic:1.2.9'
    implementation 'me.chyxion:table-to-xls:0.0.2'
}

configurations.all {
    transitive = true
}
test {
    useJUnitPlatform()
}

task sourcesJar(type: Jar, dependsOn: classes) {
    description = "打包源码"
    classifier = 'sources'
    from sourceSets.main.allSource
}

publishing {
    publications {
        mavenJava(MavenPublication) {
            groupId = group
            version = version
            from components.java
            artifact sourcesJar
        }
    }
    repositories {
        mavenLocal()
        maven {
            //  私服地址
            url rootProject['iccRepoUploadUrl']
            credentials {
                username(rootProject['repoUser'])
                password(rootProject['repoPass'])
            }
            allowInsecureProtocol = true
        }
    }
}
```
