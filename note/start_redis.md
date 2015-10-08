# 开始学习redis(草稿)

## 什么是redis

Redis is an open source, BSD licensed, advanced key-value cache and store. It is often referred to as a data structure server since keys can contain strings, hashes, lists, sets, sorted sets, bitmaps and hyperloglogs.

## 安装redis

Download, extract and compile Redis with:

```
$ wget http://download.redis.io/releases/redis-3.0.3.tar.gz
$ tar xzf redis-3.0.3.tar.gz
$ cd redis-3.0.3
$ make
```

The binaries that are now compiled are available in the src directory. Run Redis with:

```
$ src/redis-server
```

You can interact with Redis using the built-in client:

```
$ src/redis-cli
redis> set foo bar
OK
redis> get foo
"bar"
```

Redis 由四个可执行文件：redis-benchmark、redis-cli、redis-server、redis-stat 这四个文件，加上一个redis.conf就构成了整个redis的最终可用包。它们的作用如下：

- redis-server：Redis服务器的daemon启动程序
- redis-cli：Redis命令行操作工具。当然，你也可以用telnet根据其纯文本协议来操作
- redis-benchmark：Redis性能测试工具，测试Redis在你的系统及你的配置下的读写性能
- redis-stat：Redis状态检测工具，可以检测Redis当前状态参数及延迟状况

## redis 配置

redis.conf的主要配置参数的意义：

- daemonize：是否以后台daemon方式运行
- pidfile：pid文件位置
- port：监听的端口号
- timeout：请求超时时间
- loglevel：log信息级别
- logfile：log文件位置
- databases：开启数据库的数量
- save * *：保存快照的频率，第一个*表示多长时间，第三个*表示执行多少次写操作。在一定时间内执行一定数量的写操作时，自动保存快照。可设置多个条件。
- rdbcompression：是否使用压缩
- dbfilename：数据快照文件名（只是文件名，不包括目录）
- dir：数据快照的保存目录（这个是目录）
- appendonly：是否开启appendonlylog，开启的话每次写操作会记一条log，这会提高数据抗风险能力，但影响效率。
- appendfsync：appendonlylog如何同步到磁盘（三个选项，分别是每次写都强制调用fsync、每秒启用一次fsync、不调用fsync等待系统自己同步）

## redis 命令

这里有一个很不错的教程：[Try Redis](http://try.redis.io/)

### String

```
SET server:name "fido"
GET server:name => "fido"
```

`INCR` 可以让一个数值自增，并且`INCR`是原子操作。

```
    SET connections 10
    INCR connections => 11
    INCR connections => 12
    DEL connections
    INCR connections => 1
```

设置过期时间（秒）

```
SET resource:lock "Redis Demo"
EXPIRE resource:lock 120
```

查看过期时间（秒）

```
//-1表示永不过期
TTL resource:lock => -2
```

NOTE：set操作会重置TTL，使其为变为-1

### list 

list是一系列有序排列的数值，与list常用的命令有 RPUSH, LPUSH, LLEN, LRANGE, LPOP, and RPOP.。

- RPUSH 在链表末端插入值

```
RPUSH friends "Alice"
RPUSH friends "Bob"
```

- LPUSH 在链表前插入值

```
LPUSH friends "Sam"
```

- LRANGE 获取链表子集

```
LRANGE friends 0 -1 => 1) "Sam", 2) "Alice", 3) "Bob"
LRANGE friends 0 1 => 1) "Sam", 2) "Alice"
LRANGE friends 1 2 => 1) "Alice", 2) "Bob"
```

- LLEN 返回链表长度

```
LLEN friends => 3
```

- LPOP 移除链表第一个元素并返回它

```
LPOP friends => "Sam"
```

- RPOP 移除链表最后一个元素并返回它

```
RPOP friends => "Bob"
```

### set 

set与list类似，但是set中元素没有顺序，并且元素不重复。

- `SADD` 添加值到set中

```
SADD superpowers "flight"
SADD superpowers "x-ray vision"
SADD superpowers "reflexes"
```

- `SREM` 从set中移除值

```
SREM superpowers "reflexes"
```

- `SISMEMBER` 测试值是否存在于set中（1表示存在，0表示不存在）

```
SISMEMBER superpowers "flight" => 1
SISMEMBER superpowers "reflexes" => 0
```

- `SMEMVERS` 返回set中所有元素

```
SMEMBERS superpowers => 1) "flight", 2) "x-ray vision"
```

- `SUNION` 合并两个set

```
SADD birdpowers "pecking"
SADD birdpowers "flight"
SUNION superpowers birdpowers => 1) "pecking", 2) "x-ray vision", 3) "flight"
```

### sorted set

```
ZADD hackers 1940 "Alan Kay"
ZADD hackers 1906 "Grace Hopper"
ZADD hackers 1953 "Richard Stallman"
ZADD hackers 1965 "Yukihiro Matsumoto"
ZADD hackers 1916 "Claude Shannon"
ZADD hackers 1969 "Linus Torvalds"
ZADD hackers 1957 "Sophie Wilson"
ZADD hackers 1912 "Alan Turing"
```

- `ZRANGE` 获取子集

```
ZRANGE hackers 2 4 => 1) "Claude Shannon", 2) "Alan Kay", 3) "Richard Stallman"
```

### hash

- `hset` 添加单个数据

```
HSET user:1000 name "John Smith"
HSET user:1000 email "john.smith@example.com"
HSET user:1000 password "s3cret"
```

- `hmset` 一次添加多个属性

```
HMSET user:1001 name "Mary Jones" password "hidden" email "mjones@example.com"
 ```
 
- `hget` 取单个数据

```
HGET user:1001 name
```

- `hgetall` 取出所有数据

```
hgetall user:1000
```

- `hdel` 删除数据

```
hdel user:1000
```

- `hincrby` 进行数值运算

```
HSET user:1000 visits 10
HINCRBY user:1000 visits 1 => 11
HINCRBY user:1000 visits 10 => 21
HDEL user:1000 visits
HINCRBY user:1000 visits 1 => 1
```

## Java中的redis

Jedis是对于redis的Java实现，引入Jedis的Jar包就可以进行redis操作了。

参考：[java对redis的基本操作](http://www.cnblogs.com/edisonfeng/p/3571870.html)

## ShardedJedis 与 Jedis

Jedis作为推荐的java语言redis客户端

ShardedJedis是基于一致性哈希算法实现的分布式Redis集群客户端；


1. [Redis官网：Redis IO](http://redis.io/)
2. [Try Redis](http://try.redis.io/)
3. [Redis命令](http://redis.io/commands)



