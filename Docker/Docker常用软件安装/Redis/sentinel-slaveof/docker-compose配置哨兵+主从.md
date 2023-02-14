# docker-compose配置哨兵+主从

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