<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [Zookeeper 集群部署](#zookeeper-%E9%9B%86%E7%BE%A4%E9%83%A8%E7%BD%B2)
  - [Standalone 部署模式](#standalone-%E9%83%A8%E7%BD%B2%E6%A8%A1%E5%BC%8F)
    - [下载zookeeper](#%E4%B8%8B%E8%BD%BDzookeeper)
    - [修改zoo.cfg文件](#%E4%BF%AE%E6%94%B9zoocfg%E6%96%87%E4%BB%B6)
    - [启动zookeeper](#%E5%90%AF%E5%8A%A8zookeeper)
  - [本地伪集群部署模式](#%E6%9C%AC%E5%9C%B0%E4%BC%AA%E9%9B%86%E7%BE%A4%E9%83%A8%E7%BD%B2%E6%A8%A1%E5%BC%8F)
    - [修改zoo.cfg文件](#%E4%BF%AE%E6%94%B9zoocfg%E6%96%87%E4%BB%B6-1)
    - [修改zookeeper336_server_2的zoo.cfg文件](#%E4%BF%AE%E6%94%B9zookeeper336_server_2%E7%9A%84zoocfg%E6%96%87%E4%BB%B6)
    - [修改zookeeper336_server_3的zoo.cfg文件](#%E4%BF%AE%E6%94%B9zookeeper336_server_3%E7%9A%84zoocfg%E6%96%87%E4%BB%B6)
    - [启动3个zookeeper集群节点](#%E5%90%AF%E5%8A%A83%E4%B8%AAzookeeper%E9%9B%86%E7%BE%A4%E8%8A%82%E7%82%B9)
  - [zookeeper分布式集群](#zookeeper%E5%88%86%E5%B8%83%E5%BC%8F%E9%9B%86%E7%BE%A4)
  - [zoo.cfg 文件配置](#zoocfg-%E6%96%87%E4%BB%B6%E9%85%8D%E7%BD%AE)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# Zookeeper 集群部署

> 操作系统:MAC_OS_X_Yosemite
zookeeper版本:3.3.6


Zookeeper常见的有两种部署模式：Standalone模式和Distributed模式。Standalone模式更多地用于开发的测试过程，而Distributed模式更多用在应用上线之时。

在了解Zookeeper集群部署之前，我们先来了解Zookeeper的Standalone（独立）部署模式。

## Standalone 部署模式

### 下载zookeeper

如果你还没有zookeeper，那直接到[zookeeper官网](zookeeper.apache.org)下载。

下载完成后直接解压`.tar.gz`文件就可以直接使用了。为了方便后面集群部署，这里将zookeeper文件夹名更改为：`zookeeper336_server_1`。

### 修改zoo.cfg文件

zookeeper官方提供了一个zoo_sample.cfg文件，将这个文件重命名为`zoo.cfg`。

修改conf/zoo.cfg文件：

```
# 心跳基本单位(毫秒)
tickTime=2000
# 初始化过程需要花费的心跳数（=心跳数*基本单位）
initLimit=10
# 表示fowller与leader的心跳时间是2 tick
syncLimit=5
# 内存数据结构的snapshot
dataDir=../data
# 日志信息
dataLogDir=../log
# 客户端连接zookeeper服务的端口
clientPort=2181
```

NOTE：更多关于`zoo.cfg`文件的配置，可以点击[这里](zookeeper_deployment_guidence_zoo_cfg_settings.md)

### 启动zookeeper

命令行切换到bin目录下，启动zookeeper

```
localhost:bin yurongchan$ sudo zkServer.sh start
```

如果没有发生错误，console就会提供启动成功。这时我们用另一个命令来查看一下zookeeper是否真的启动成功。

```
localhost:bin yurongchan$ sudo zkServer.sh status
```

从弹出的信息可以看到zookeeper此时正在运行，而且运行模式是standalone模式。

NOTE：你可以输入`zkServer.sh`查看zookeeper还有其他哪些命令。

## 本地伪集群部署模式

本地伪集群指的是将本来应该部署在不同机器上的zookeeper放在同一台机器上运行，因为一般情况下没有太多机器给我们使用。

### 修改zoo.cfg文件

在上面文件的基础上，加上以下配置：

```
# config the distributed mode 
# local simulate distributed 
server.1=127.0.0.1:20881:30881
server.2=127.0.0.1:20882:30882
server.3=127.0.0.1:20883:30883
```

上面配置了3个节点集群，每一行就是一个集群节点配置。每个集群节点配置有两个TCP port，后面一个是用于Zookeeper选举用的，而前一个是Leader和Follower或Observer交换数据使用的。我们还注意到server.后面的数字，这个就是myid（这个会在后面介绍）。

加上上面的配置之后，`zoo.cfg`文件就是这样：

```
# The number of milliseconds of each tick
# 心跳基本单位(毫秒)
tickTime=2000
# The number of ticks that the initial 
# synchronization phase can take
# 初始化过程需要花费的心跳数（=心跳数*基本单位）
initLimit=10
# The number of ticks that can pass between 
# sending a request and getting an acknowledgement
# 表示fowller与leader的心跳时间是2 tick
syncLimit=5
# the directory where the snapshot is stored.
# 内存数据结构的snapshot
dataDir=../data
# the directory where the log is stored.
# 日志信息
dataLogDir=../log
# the port at which the clients will connect
# 客户端连接zookeeper服务的端口
clientPort=2181
# 配置分布式集群
# config the distributed mode 
# local simulate distributed 
server.1=127.0.0.1:20881:30881
server.2=127.0.0.1:20882:30882
server.3=127.0.0.1:20883:30883
```

之后子啊我们配置的`dataDir`目录下（这里是./data目录）创建`myid`文件，内容为这台集群节点的编号，也就是在`zoo.cfg`文件里配置的那个数字。这里是`zookeeper336_server_1`，所以直接在`myid`里写上数字`1`保存即可。

将上面配好的`zookeeper336_server_1`文件夹多复制两份，分别命名为：

`zookeeper336_server_2`，`zookeeper336_server_3`。

### 修改zookeeper336_server_2的zoo.cfg文件

因为我们是在本地启动多个zookeeper，所以需要修改clientPort监听的端口，这里将server2的clientPort修改为2182：

```
# 客户端连接zookeeper服务的端口
clientPort=2182
```

修改`myid`文件内容为`2`

### 修改zookeeper336_server_3的zoo.cfg文件

因为我们是在本地启动多个zookeeper，所以需要修改clientPort监听的端口，这里将server3的clientPort修改为2183：

```
# 客户端连接zookeeper服务的端口
clientPort=2183
```

修改`myid`文件内容为`3`

### 启动3个zookeeper集群节点

启动3个命令行窗口，用`sudo zkServer.sh start-foreground`分别启动3个集群节点。

![](img/Z/zookeeper_distributed_mode.png)

之后用`sudo zkServer.sh status`命令可以看到每个集群节点的状态信息。其中我们可以看到第2个集群节点是Lead节点。

## zookeeper分布式集群

一般情况下，如果我们是在不同机器上进行zookeeper集群部署，那么我们只需要一份`zoo.cfg`文件即可，而不需要对不同节点的配置文件进行修改。

```
# The number of milliseconds of each tick
# 心跳基本单位(毫秒)
tickTime=2000
# The number of ticks that the initial 
# synchronization phase can take
# 初始化过程需要花费的心跳数（=心跳数*基本单位）
initLimit=10
# The number of ticks that can pass between 
# sending a request and getting an acknowledgement
# 表示fowller与leader的心跳时间是2 tick
syncLimit=5
# the directory where the snapshot is stored.
# 内存数据结构的snapshot
dataDir=../data
# the directory where the log is stored.
# 日志信息
dataLogDir=../log
# the port at which the clients will connect
# 客户端连接zookeeper服务的端口
clientPort=2181
# 配置分布式集群
# config the distributed mode 
# local simulate distributed 
server.1=192.168.1.1:2088:3088
server.2=192.168.1.2:2088:3088
server.3=192.168.1.3:2088:3088
```

上面的配置标明一共有3个集群，地址分别是：192.168.1.1~3，他们都用2088和3088做数据传输端口和选举端口。

之后直接将这份文件拷贝至其他机器上覆盖，然后改变`myid`文件内容即可。

## zoo.cfg 文件配置

|属性|含义|
|---|---|
|clientPort=2181|客户端连接zookeeper服务的端口，这是一个TCP port|
|dataDir=/data|dataDir里放的是内存数据结构的snapshot，便于快速恢复。|
|dataLogDir=/datalog|dataLogDir里是放到的顺序日志(WAL)|
|tickTime = 3000|这是个时间单位定量。比如tickTime=1000，这就表示在zookeeper里1 tick表示1000 ms，所有其他用到时间的地方都会用多少tick来表示。|
|syncLimit = 2|表示fowller与leader的心跳时间是2 tick|
|maxClientCnxns=100|对于一个客户端的连接数限制，默认是60，这在大部分时候是足够了。但是在我们实际使用中发现，在测试环境经常超过这个数，经过调查发现有的团队将几十个应用全部部署到一台机器上，以方便测试，于是这个数字就超过了。|
|minSessionTimeout, maxSessionTimeout|一般，客户端连接zookeeper的时候，都会设置一个session timeout，如果超过这个时间client没有与zookeeper server有联系，则这个session会被设置为过期(如果这个session上有临时节点，则会被全部删除，这就是实现集群感知的基础，后面的文章会介绍这一点)。但是这个时间不是客户端可以无限制设置的，服务器可以设置这两个参数来限制客户端设置的范围。|
|autopurge.snapRetainCount，autopurge.purgeInterval|客户端在与zookeeper交互过程中会产生非常多的日志，而且zookeeper也会将内存中的数据作为snapshot保存下来，这些数据是不会被自动删除的，这样磁盘中这样的数据就会越来越多。不过可以通过这两个参数来设置，让zookeeper自动删除数据。autopurge.purgeInterval就是设置多少小时清理一次。而autopurge.snapRetainCount是设置保留多少个snapshot，之前的则删除。|