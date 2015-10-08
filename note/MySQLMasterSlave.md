# MySQL 主从同步

## 1. 为什么要用主从同步

主从备份可以实现读写分离，读取数据从从库上读取，写入数据从主库写入（即简单级别的读写分离），降低数据库负荷。另一方面，主从备份也可以当成是一种简单的数据库别分机制。

## 2. 数据库环境

我将建立3个数据库服务器，其中一个是主库，建立在Windows系统上；另外两个是从库，一个建立在Windows系统上，一个建立在Mac上。

- 主库信息

IP：10.3.83.114

系统：Windows 7

- 从库1信息

IP：10.3.83.77

系统：Mac OS X Yosemite


**关于MySQL配置文件**

MySQL配置文件在Windows系统下的路径是：C:\Program Files (x86)\MySQL\MySQL Server 5.5\my.ini

MySQL配置文件在类Linux系统下的路径是：/usr/local/mysql-5.6.25-osx10.8-x86_64/my.cnf

下面我们将开始数据库主从同步的配置。在开始之前，请确保你已经在所有机器上正确安装了MySQL数据库。如果可以，请尽量安装相同版本的MySQL数据库。

## 3. 配置主库

### 3.1 配置my.ini文件

打开主库配置文件my.ini，在最后加上下面的配置

```xml
# Configure the Master and Slave 
server-id=1   
binlog_do_db = test
log-bin=master-bin
log-bin-index=master-bin.index
```

- server-id：给该数据库的唯一标识，一般为大家设置服务器Ip的末尾号
- binlog_do_db：指定要进行主从同步的数据库
- log-bin：指定数据库启用二进制日志，并且用其值作为二进制日志所产生的所有文件的基本名
- log-bin-index：指定了一个索引文件（纯文本，内容为文件列表），该索引文件中包含所有二进制文件的列表。如果没有为log-bin-index设置默认值，则会使用机器的hostname产生log-bin-index文件，这样，在服务器的hostname改变后，可能会出现无法找到索引文件，从而认为二进制文件列表为空，导致无法正确的生成二进制bin-log。一般情况下使用与log-bin值相同的值。

### 3.2 创建从库同步用户

进入MySQL控制台，输入以下命令创建一个用于从库同步数据的用户，并赋予其相应的权限。

```xml
Create user reply_user;
Grant REPLICATION SLAVE On *.* to 'reply_user'@'%' IDENTIFIED BY 'xxxxxxxxx';
Flush privileges;
```

'reply_user'@'%'表示让reply_user能从任何一个IP上登录到主库。

### 3.3 锁定主库并获取备份

在进行同步之前，我们必须让主库和从库完全一样。当然如果你的数据库都是新创建的，那么就不必做这样的操作了。

进入主库的MySQL控制台，输入以下命令锁定数据库。

```xml
USE test;
FLUSH TABLES WITH READ LOCK;
```

之后输入命令`SHOW MASTER STATUS;`查看MASTER运行状态：

```xml
mysql> SHOW MASTER STATUS;
+-------------------+----------+--------------+------------------+
| File | Position | Binlog_Do_DB | Binlog_Ignore_DB |
+-------------------+----------+--------------+------------------+
| master-bin.000001 | 1285 | | |
+-------------------+----------+--------------+------------------+
1 row in set (0.00 sec)
```

记下上面的master-bin.000001和1285，下面会用到。

之后导出数据库的备份：

`mysqldump -u root -p --opt newdatabase > newdatabase.sql`

之后输入以下命令解除主库锁定：

`UNLOCK TABLES;`

## 4. 配置从库

### 4.1 恢复从库数据

创建与主库相同的数据库：   

`CREATE DATABASE newdatabase;`

之后用主库的备份文件恢复数据库：

mysql -u root -p newdatabase < /path/to/newdatabase.sql

### 4.2 配置从库my.cnf文件

在my.cnf文件里添加以下配置：

```xml
server-id = 3
relay_log=slave-relay-bin
relay_log_index=slave-relay-bin.index
binlog_do_db = test
#log_bin:slave-bin
#log_slave_updates = 1
```

- server-id：标识该数据库服务器的唯一ID
- relay_log：中继日志。主库的日志文件传到从库后写入relay_log中，从库的slave sql线程再从relay_log里读取然后应用到本地。
- relay_log_index：指定了一个索引文件（纯文本，内容为文件列表），该索引文件中包含所有二进制文件的列表。与log-in-index参数类似。
- log_bin：开启二进制日志记录，这里不是必须的，但是如果slave为其它slave的master，必须设置 bin_log
- log_slave_updates：表示slave将复制事件写进自己的二进制日志

之后重启MySQL：    

`sudo /Library/StartupItems/MySQLCOM/MySQLCOM restart`

## 5. 将从库连接到主库

将Slave连接到Master,需要知道Master的四个基本的信息：

- 1. 主机名或者IP地址，由于这里都是单机，主机的IP为127.0.0.1

- 2. Master使用的端口号，3306

- 3. Master上具有REPLICATION SLAVE权限的用户

- 4. 该账号的密码

- 5. 从哪个日志文件开始同步

- 6. 从这个日志文件的哪个位置开始同步

在配置Master的时候已经创建了一个具有相关权限的用户，并且在备份主库的时候已经记下了第5、6项的值。在Slave的控制台运行以下命令：

```xml
change master to master_host='10.3.83.114',
master_port=3306,
master_user='repl',
master_password='repl', 
master_log_file='master-bin.000003', 
master_log_pos=190;
```

之后启动从库备份：

`start slave;`

查看从库备份状态：

`show slave status\G;`

在弹出的信息中查看Slave_IO_Running和Slave_SQL_Running值是否为YES，是就说明成功了。

## 6. 测试主从同步

在主库上进行一些CRUD操作，之后刷新从库，查看是否进行同步了。