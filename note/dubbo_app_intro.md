# dubbo+zookeeper构建分布式应用

本文简单记录下如何用dubbo+zookeeper构建一个分布式应用，应用各个方面采取的技术如下所示：

>技术框架：struts + MyBatis + Spring
分布式服务：dubbo + zookeeper
缓存：redis + memcache
数据库：主从分离 + 数据库路由
负载均衡：nginx

## 技术框架

现在用Java进行J2EE开始的常用框架有两种形式：

1. SpringMVC + MyBatis 
2. struts + MyBatis + Spring

这里将先采用第二种。

## dubbo + zookeeper

zookeeper是谷歌的一个开源项目，能解决分布式服务的通信问题。而dubbo是阿里巴巴的一个分布式服务框架，它使用了zookeeper进行底层服务的管理。利用dubbo + zookeeper，我们可以将服务注册到zookeeper上，也可以从zookeeper上调用服务，并且将服务与Spring结合实现反转注入。

### 安装管理控制台

通过阿里巴巴提供的`dubbo console`，我们可以非常清晰地知道本机上注册了哪些服务，这些服务分别有哪些消费者。

下载[dubbo-admin.war](src/dubbo-admin-2.5.4.war)，将其解压后放在任意一个tomcat下。

```
cd apache-tomcat-6.0.35
rm -rf webapps/ROOT
unzip dubbo-admin-2.4.1.war -d webapps/ROOT
```

配置dubbo.properties

```
vi webapps/ROOT/WEB-INF/dubbo.properties
```

```
//dubbo.properties
dubbo.registry.address=zookeeper://127.0.0.1:2181
dubbo.admin.root.password=root
dubbo.admin.guest.password=guest
```

上面的`dubbo.registry.address`配置的是zookeeper服务器的IP地址。只要配了这个，无论你在哪个机器上运行控制台，都可以获取到相应的数据。因此，控制台不一定要部署在zookeeper服务器对应的机器上，在其他机器上也可以。

### 启动、停止、访问控制台

```
//启动
./bin/startup.sh
//关闭
./bin/shutdown.sh
//访问(用户:root,密码:root 或 用户:guest,密码:guest)
http://127.0.0.1:8080/
```


## 缓存

## 数据库

## 负载均衡

## 部署demo

demo部署需要两台机器，一个扮演服务提供者provider，一个扮演服务调用者consumer。

### 创建数据库

在服务端（Provider）创建数据库并插入数据：

```
create database test;create table user(	id int,	username varchar(100),	password varchar(100));insert into user values(1,'123','123');insert into user values(2,'admin','password');commit;```
NOTE：数据库与服务端在同一台机器。

### 启动服务端 provider

`SuperDemo`工程里分别有4个模块：

- core-interface 核心接口模块。存放了所有提供服务的接口。
- core-model 核心模型模块。存放了所有核心模型。
- core 核心服务模块。提供所有核心的服务。
- app 应用模块。是一个web工程，提供web页面给用户访问。

其中core是服务提供者，app是服务调用者。

在服务端这里，需要用到的模块只有`core-interface` `core-model` `core` 一共3个模块。

首先将`SuperDemo`工程复制一份，之后用`clean install`编译整个项目。然后启动一个zookeeper服务器，之后打开core中的dubbo.properties文件，修改`dubbo.registry.address`地址（服务注册地址，即zookeeper所在服务器地址），之后启动`core`项目里的`Launcher.main()`。

### 启动消费端 consumer

在消费端这里，需要用到的模块只有`core-interface` `core-model` `app` 一共3个模块。app通过`core-interface`提供的接口调用服务端（core）注册在zookeeper的服务。

首先将`SuperDemo`工程复制一份，之后用`clean install`编译整个项目。之后修改app中的dubbo.properties文件，修改`dubbo.registry.address`地址。之后用`tomat7:run`启动app项目，在浏览器访问。









