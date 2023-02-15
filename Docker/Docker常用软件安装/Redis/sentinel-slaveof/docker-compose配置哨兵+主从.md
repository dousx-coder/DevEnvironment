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
- [config.sh](./config.sh)
  -  `vmIp=192.168.96.151`根据主机ip修改
- [docker-compose.yml](./docker-compose.yml)
```sh
sudo chmod +x config.sh && sudo sh config.sh
```
2. 启动
```sh
docker-compose up -d
```
```
sudo chmod +x config.sh && sudo sh config.sh && docker-compose up -d
```
3. 查看日志
```sh
docker logs -f redis-sentinel-1
```
**当`master`节点停掉之后，选举`192.168.111.172 6373`作为新的`master`节点**
```sh
1:X 15 Feb 2023 09:07:19.814 # oO0OoO0OoO0Oo Redis is starting oO0OoO0OoO0Oo
1:X 15 Feb 2023 09:07:19.815 # Redis version=6.2.4, bits=64, commit=00000000, modified=0, pid=1, just started
1:X 15 Feb 2023 09:07:19.815 # Configuration loaded
1:X 15 Feb 2023 09:07:19.817 * monotonic clock: POSIX clock_gettime
1:X 15 Feb 2023 09:07:19.818 * Running mode=sentinel, port=26379.
1:X 15 Feb 2023 09:07:19.824 # Sentinel ID is c6f8f0587601f9ba2b3e33aaa22d57527dc665b7
1:X 15 Feb 2023 09:07:19.824 # +monitor master redis-nodes 192.168.111.172 6371 quorum 2
1:X 15 Feb 2023 09:07:19.827 * +slave slave 192.168.111.172:6372 192.168.111.172 6372 @ redis-nodes 192.168.111.172 6371
1:X 15 Feb 2023 09:07:19.833 * +slave slave 192.168.111.172:6373 192.168.111.172 6373 @ redis-nodes 192.168.111.172 6371
1:X 15 Feb 2023 09:07:21.348 * +sentinel sentinel 86a7cde1b12055661f3777d0f6ba761afec7df7e 192.168.111.172 26372 @ redis-nodes 192.168.111.172 6371
1:X 15 Feb 2023 09:07:21.551 * +sentinel sentinel bfa2427740dbecb9cedeca76da4104856cfaf764 192.168.111.172 26373 @ redis-nodes 192.168.111.172 6371
1:X 15 Feb 2023 09:11:09.646 # +sdown master redis-nodes 192.168.111.172 6371
1:X 15 Feb 2023 09:11:09.718 # +odown master redis-nodes 192.168.111.172 6371 #quorum 3/2
1:X 15 Feb 2023 09:11:09.718 # +new-epoch 1
1:X 15 Feb 2023 09:11:09.718 # +try-failover master redis-nodes 192.168.111.172 6371
1:X 15 Feb 2023 09:11:09.720 # +vote-for-leader c6f8f0587601f9ba2b3e33aaa22d57527dc665b7 1
1:X 15 Feb 2023 09:11:09.724 # 86a7cde1b12055661f3777d0f6ba761afec7df7e voted for c6f8f0587601f9ba2b3e33aaa22d57527dc665b7 1
1:X 15 Feb 2023 09:11:09.726 # bfa2427740dbecb9cedeca76da4104856cfaf764 voted for c6f8f0587601f9ba2b3e33aaa22d57527dc665b7 1
1:X 15 Feb 2023 09:11:09.805 # +elected-leader master redis-nodes 192.168.111.172 6371
1:X 15 Feb 2023 09:11:09.805 # +failover-state-select-slave master redis-nodes 192.168.111.172 6371
1:X 15 Feb 2023 09:11:09.906 # +selected-slave slave 192.168.111.172:6373 192.168.111.172 6373 @ redis-nodes 192.168.111.172 6371
1:X 15 Feb 2023 09:11:09.906 * +failover-state-send-slaveof-noone slave 192.168.111.172:6373 192.168.111.172 6373 @ redis-nodes 192.168.111.172 6371
1:X 15 Feb 2023 09:11:09.959 * +failover-state-wait-promotion slave 192.168.111.172:6373 192.168.111.172 6373 @ redis-nodes 192.168.111.172 6371
1:X 15 Feb 2023 09:11:10.861 # +promoted-slave slave 192.168.111.172:6373 192.168.111.172 6373 @ redis-nodes 192.168.111.172 6371
1:X 15 Feb 2023 09:11:10.861 # +failover-state-reconf-slaves master redis-nodes 192.168.111.172 6371
1:X 15 Feb 2023 09:11:10.915 * +slave-reconf-sent slave 192.168.111.172:6372 192.168.111.172 6372 @ redis-nodes 192.168.111.172 6371
1:X 15 Feb 2023 09:11:11.900 # -odown master redis-nodes 192.168.111.172 6371
1:X 15 Feb 2023 09:11:11.901 * +slave-reconf-inprog slave 192.168.111.172:6372 192.168.111.172 6372 @ redis-nodes 192.168.111.172 6371
1:X 15 Feb 2023 09:11:11.902 * +slave-reconf-done slave 192.168.111.172:6372 192.168.111.172 6372 @ redis-nodes 192.168.111.172 6371
1:X 15 Feb 2023 09:11:11.990 # +failover-end master redis-nodes 192.168.111.172 6371
1:X 15 Feb 2023 09:11:11.990 # +switch-master redis-nodes 192.168.111.172 6371 192.168.111.172 6373
1:X 15 Feb 2023 09:11:11.991 * +slave slave 192.168.111.172:6372 192.168.111.172 6372 @ redis-nodes 192.168.111.172 6373
1:X 15 Feb 2023 09:11:11.991 * +slave slave 192.168.111.172:6371 192.168.111.172 6371 @ redis-nodes 192.168.111.172 6373
```

4. 查看主从
```sh
docker exec  redis-node-1  redis-cli info replication
```


## 已踩坑
```
WARNING: Sentinel was not able to save the new configuration on disk!!!: Device or resource busy
```
- 解决方法是使用目录映射
- [stackoverflow](https://stackoverflow.com/questions/70384566/warning-sentinel-was-not-able-to-save-the-new-configuration-on-disk-device)
- [issue-8172](https://github.com/redis/redis/issues/8172)

## 待解决问题
redis配置文件中配置`slaveof ${vmIp} 6371`,跟哨兵选出来的`master`冲突,`redisson`会提示`Skipped slave up`?
- [1560](https://github.com/redisson/redisson/issues/1560)
- [1324](https://github.com/redisson/redisson/issues/1324)
- [哨兵模式不停警告 Skipped slave up](https://github.com/redisson/redisson/issues/2134)


当节点停掉之后，`redisson`提示`Unable to connect to Redis server`
```log
2023-02-15 14:38:48.263 [redisson-netty-2-5] ERROR o.r.c.b.LoadBalancerManager.lambda$unfreeze$3 [163] - Unable to unfreeze entry: [freeSubscribeConnectionsAmount=0, freeSubscribeConnectionsCounter=value:64:queue:0, freeConnectionsAmount=0, freeConnectionsCounter=value:92:queue:0, freezeReason=SYSTEM, client=[addr=redis://192.168.111.172:6371], nodeType=SLAVE, firstFail=1676443116527]
java.util.concurrent.CompletionException: org.redisson.client.RedisConnectionException: Unable to connect to Redis server: 192.168.111.172/192.168.111.172:6371
	at java.base/java.util.concurrent.CompletableFuture.encodeThrowable(CompletableFuture.java:332)
	at java.base/java.util.concurrent.CompletableFuture.completeThrowable(CompletableFuture.java:347)
	at java.base/java.util.concurrent.CompletableFuture$BiRelay.tryFire(CompletableFuture.java:1498)
	at java.base/java.util.concurrent.CompletableFuture$CoCompletion.tryFire(CompletableFuture.java:1219)
	at java.base/java.util.concurrent.CompletableFuture.postComplete(CompletableFuture.java:510)
	at java.base/java.util.concurrent.CompletableFuture.completeExceptionally(CompletableFuture.java:2162)
	at org.redisson.connection.pool.ConnectionPool.lambda$createConnection$1(ConnectionPool.java:151)
	at java.base/java.util.concurrent.CompletableFuture.uniWhenComplete(CompletableFuture.java:863)
	at java.base/java.util.concurrent.CompletableFuture$UniWhenComplete.tryFire(CompletableFuture.java:841)
	at java.base/java.util.concurrent.CompletableFuture.postComplete(CompletableFuture.java:510)
	at java.base/java.util.concurrent.CompletableFuture.completeExceptionally(CompletableFuture.java:2162)
	at org.redisson.connection.pool.ConnectionPool.promiseFailure(ConnectionPool.java:307)
	at org.redisson.connection.pool.ConnectionPool.lambda$createConnection$6(ConnectionPool.java:273)
	at java.base/java.util.concurrent.CompletableFuture.uniWhenComplete(CompletableFuture.java:863)
	at java.base/java.util.concurrent.CompletableFuture$UniWhenComplete.tryFire(CompletableFuture.java:841)
	at java.base/java.util.concurrent.CompletableFuture.postComplete(CompletableFuture.java:510)
	at java.base/java.util.concurrent.CompletableFuture.completeExceptionally(CompletableFuture.java:2162)
	at org.redisson.client.RedisClient$2$2.run(RedisClient.java:292)
	at io.netty.util.concurrent.AbstractEventExecutor.runTask$$$capture(AbstractEventExecutor.java:174)
	at io.netty.util.concurrent.AbstractEventExecutor.runTask(AbstractEventExecutor.java)
	at io.netty.util.concurrent.AbstractEventExecutor.safeExecute$$$capture(AbstractEventExecutor.java:167)
	at io.netty.util.concurrent.AbstractEventExecutor.safeExecute(AbstractEventExecutor.java)
	at io.netty.util.concurrent.SingleThreadEventExecutor.runAllTasks(SingleThreadEventExecutor.java:470)
	at io.netty.channel.nio.NioEventLoop.run(NioEventLoop.java:569)
	at io.netty.util.concurrent.SingleThreadEventExecutor$4.run(SingleThreadEventExecutor.java:997)
	at io.netty.util.internal.ThreadExecutorMap$2.run(ThreadExecutorMap.java:74)
	at io.netty.util.concurrent.FastThreadLocalRunnable.run(FastThreadLocalRunnable.java:30)
	at java.base/java.lang.Thread.run(Thread.java:833)
Caused by: org.redisson.client.RedisConnectionException: Unable to connect to Redis server: 192.168.111.172/192.168.111.172:6371
	at org.redisson.connection.pool.ConnectionPool.lambda$createConnection$1(ConnectionPool.java:150)
	at java.base/java.util.concurrent.CompletableFuture.uniWhenComplete(CompletableFuture.java:863)
	at java.base/java.util.concurrent.CompletableFuture$UniWhenComplete.tryFire(CompletableFuture.java:841)
	at java.base/java.util.concurrent.CompletableFuture.postComplete(CompletableFuture.java:510)
	at java.base/java.util.concurrent.CompletableFuture.completeExceptionally(CompletableFuture.java:2162)
	at org.redisson.connection.pool.ConnectionPool.promiseFailure(ConnectionPool.java:307)
	at org.redisson.connection.pool.ConnectionPool.lambda$createConnection$6(ConnectionPool.java:273)
	at java.base/java.util.concurrent.CompletableFuture.uniWhenComplete(CompletableFuture.java:863)
	at java.base/java.util.concurrent.CompletableFuture$UniWhenComplete.tryFire(CompletableFuture.java:841)
	at java.base/java.util.concurrent.CompletableFuture.postComplete(CompletableFuture.java:510)
	at java.base/java.util.concurrent.CompletableFuture.completeExceptionally(CompletableFuture.java:2162)
	at org.redisson.client.RedisClient$1$2.run(RedisClient.java:235)
	... 10 common frames omitted
Caused by: java.util.concurrent.CompletionException: io.netty.channel.AbstractChannel$AnnotatedConnectException: Connection refused: no further information: 192.168.111.172/192.168.111.172:6371
	at java.base/java.util.concurrent.CompletableFuture.encodeRelay(CompletableFuture.java:368)
	at java.base/java.util.concurrent.CompletableFuture.completeRelay(CompletableFuture.java:377)
	at java.base/java.util.concurrent.CompletableFuture$UniRelay.tryFire(CompletableFuture.java:1097)
	... 13 common frames omitted
Caused by: io.netty.channel.AbstractChannel$AnnotatedConnectException: Connection refused: no further information: 192.168.111.172/192.168.111.172:6371
Caused by: java.net.ConnectException: Connection refused: no further information
	at java.base/sun.nio.ch.Net.pollConnect(Native Method)
	at java.base/sun.nio.ch.Net.pollConnectNow(Net.java:672)
	at java.base/sun.nio.ch.SocketChannelImpl.finishConnect(SocketChannelImpl.java:946)
	at io.netty.channel.socket.nio.NioSocketChannel.doFinishConnect(NioSocketChannel.java:337)
	at io.netty.channel.nio.AbstractNioChannel$AbstractNioUnsafe.finishConnect(AbstractNioChannel.java:334)
	at io.netty.channel.nio.NioEventLoop.processSelectedKey(NioEventLoop.java:776)
	at io.netty.channel.nio.NioEventLoop.processSelectedKeysOptimized(NioEventLoop.java:724)
	at io.netty.channel.nio.NioEventLoop.processSelectedKeys(NioEventLoop.java:650)
	at io.netty.channel.nio.NioEventLoop.run(NioEventLoop.java:562)
	at io.netty.util.concurrent.SingleThreadEventExecutor$4.run(SingleThreadEventExecutor.java:997)
	at io.netty.util.internal.ThreadExecutorMap$2.run(ThreadExecutorMap.java:74)
	at io.netty.util.concurrent.FastThreadLocalRunnable.run(FastThreadLocalRunnable.java:30)
	at java.base/java.lang.Thread.run(Thread.java:833)
```
