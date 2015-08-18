# Linux环境变量设置

## Linux启动过程

在Linux系统启动的时候，首先会读取`/etc/profile`配置文件，这是一个系统级别的配置文件，它为所有用户设置环境变量。接下来则是会读取用户自定义的个人配置文件。bash读取的文件总共有三种：

- ~/.bash_profile（Linux 里面是 .bashrc 而 Mac 是 .bash_profile） 　　
- ~/.bash_login  　　
- ~/.profile

其实bash读取完`/etc/profile`文件后，只会再读上面文件中的一个，而读取的顺序则是依照上面的顺序。也就是说读到bash_profile就不读后面的了，如果bash_profile不存在，后面的才能有机会。

## 配置环境变量

配置环境变量一般有两个级别：系统级别、用户级别，它们分别对应系统级别配置文件和用户级别配置文件。

### 系统级别配置文件 

系统级别配置文件的配置是全局（公有）配置，不管是哪个用户，登录时都会读取该文件。系统级别变量的配置文件有两个：

- `/etc/profile`
- `/etc/bashrc`

这两个文件的区别就是：当用户登录的时候，会执行`/etc/profile`文件。而当用户打开bash（console）时，会执行`/etc/bashrc`文件。

因为bashrc是在打开bash的时候才会执行，而profile是在登录的时候执行。所以一般情况下我们把JAVA_HOME/PATH等变量放在profile文件中，而mysql、mysqlstart这些只在bash中运行的命令放在bashrc文件中。

`/etc/profile`文件配置的变量主要有：

- PATH：会依据 UID 决定 PATH 变量要不要含有 sbin 的系统命令目录；
- MAIL：依据账号配置好使用者的 mailbox 到 /var/spool/mail/账号名；
- USER：根据用户的账号配置此一变量内容；
- HOSTNAME：依据主机的 hostname 命令决定此一变量内容；
- HISTSIZE：历史命令记录笔数。CentOS 5.x 配置为 1000 ；

### 用户级别配置文件

我们一般在`~/.bash_profile`文件中设置用户级别的环境变量。如果`~/.bash_profile`中设置的环境变量与`/etc/profile`文件中的重复，则`~/.bash_profile`会覆盖之前的设置。



### 

|配置文件|解释|
|---|---|
|/etc/profile|系统级别|
|~/.bash_profile、~/.bash_login、~/.profile|用户级别|



参考资料：   

[1].[http://www.cnblogs.com/ebread/p/4011150.html](http://www.cnblogs.com/ebread/p/4011150.html)

