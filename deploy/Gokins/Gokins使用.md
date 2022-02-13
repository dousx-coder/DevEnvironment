# Gokins使用

新建流水线

指定`代码地址`、`具有访问该代码仓库的账户名`、`以及Access Token`

然后通过yaml配置流水线任务

```yaml
version: 1.0
vars:
  server: 192.168.174.202
  username: root
  password: dousx...
  pipname: es-ext-dic
stages:
  - stage:
    displayName: es-ext-dic
    name: es-ext-dic
    steps:
      - step: shell@sh
        displayName: Pipeline
        name: auto-Pipeline
        env:
        commands:
          - mvn clean package -B -Dmaven.test.skip=true
          - ls target
          - sshpass -p ${{password}} scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no target/${{pipname}}.jar ${{username}}@${{server}}:/usr/local/program/${{pipname}}/${{pipname}}.jar
          - sshpass -p ${{password}} ssh -o StrictHostKeyChecking=no ${{username}}@${{server}} sh /usr/local/program/${{pipname}}/app.sh restart
```

