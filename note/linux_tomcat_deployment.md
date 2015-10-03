# Linux下Tomcat的部署

下载Tomcat的对应版本，如 [http://tomcat.apache.org/download-70.cgi](http://tomcat.apache.org/download-70.cgi) 里面的 zip ，下载完成后直接解压。

这里需要解决两个问题：一个是**脚本的权限问题**，一个是**Java的环境变量问题**。

## 脚本权限问题

在终端中定位到tomcat目录下，输入：

`sudo chmod 755 ./bin/*.sh`

## Java环境变量问题

配置JAVA_HOME环境变量，在`/etc/profile`文件中添加以下代码：

```
# set the JAVA
JAVA_HOME=/usr/java/jdk1.7.0_67
JRE_HOME= $JAVA_HOME/jre
PATH=$PATH:$JAVA_HOME/bin:$JRE_HOME/bin
CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/rt.jar:$JAVA_HOME/lib/tools.jar:$JRE_HOME/lib
export JAVA_HOME JRE_HOME PATH CLASSPATH
```
 
都设置好之后，在终端中进入到bin目录下，输入：`startup.sh`，可以看到出现Java的图标，然后在http://localhost:8080/中可以看到Tomcat的管理页面。

**查看tomcat日志**

`vim logs/catalina.out`

**运行tomcat并实时输出日志信息**

`sh bin/catalina.sh run`



