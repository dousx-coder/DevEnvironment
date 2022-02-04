## Docker部署ELK

```sh
git clone https://github.com/DouShaoxun/docker-elk.git
cd docker-elk
docker-compose up -d
```

启动成功之后打开

http://ip:5601/

密码在/kibana/config/kibana.yml

```yaml
---
## Default Kibana configuration from Kibana base image.
## https://github.com/elastic/kibana/blob/master/src/dev/build/tasks/os_packages/docker_generator/templates/kibana_yml.template.ts
#
server.name: kibana
server.host: 0.0.0.0
elasticsearch.hosts: [ "http://elasticsearch:9200" ]
monitoring.ui.container.elasticsearch.enabled: true

## X-Pack security credentials
#
elasticsearch.username: elastic
elasticsearch.password: changeme
# 默认没有这一句，配置这一句则为中文显示
i18n.locale: "zh-CN"
```

`logstash/pipeline/logstash.conf`

```
input {
        beats {
                port => 5044
        }

        tcp {
                host => "0.0.0.0"
                port => 5000
        }
}

## Add your filters / logstash plugins configuration here

output {
        elasticsearch {
                hosts => "elasticsearch:9200"
                user => "elastic"
                password => "changeme"
                ecs_compatibility => disabled
                index => "logstash-service-%{+YYYY.MM.dd}"
        }
}
```



