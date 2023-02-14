# docker-compose配置哨兵+主从
>server-name:自定义集群名，如果需要监控多个redis集群，只需要配置多次并定义不同的<server-name> 
>
> `<master-redis-ip>`:主库ip 
>
>`<master-redis-port>`:主库port 
>
>`<quorum>`:最小投票数，由于有三台redis-sentinel实例，所以可以设置成2
## docker-compose配置哨兵+主从
1. 创建配置文件
[config.sh](./config.sh)
```sh
sudo chmod +x config.sh && sudo sh config.sh
```
2. 启动
```sh
docker-compose up -d
```
## 待解决问题
```
WARNING: Sentinel was not able to save the new configuration on disk!!!: Device or resource busy
```