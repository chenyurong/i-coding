# Linux下Tomcat的部署

由于前几天重装了Mac的系统，准备接下来把一些必需的实验环境都搭建起来。这里简单总结一下在Mac OS X上部署Tomcat应该注意的事情：

下载Tomcat的对应版本，如 `http://tomcat.apache.org/download-70.cgi` 里面的 zip 。下载在希望部署的目录下解压。这里需要解决两个问题：一个是脚本的权限问题，一个是Java的环境变量问题。

**脚本权限问题**

在终端中定位到tomcat目录下，输入：

`sudo chmod 755 ./bin/*.sh`

**Java环境变量问题**

配置JAVA_HOME环境变量，在`/etc/profile`文件中添加以下代码：

`export JAVA_HOME=/usr/libexec/java_home`
 

都设置好之后，在终端中进入到bin目录下，输入：`startup.sh`，可以看到出现Java的图标，然后在http://localhost:8080/中可以看到Tomcat的管理页面。我现在还没搞清楚，怎么能看到Tomcat的控制台输出？

**查看tomcat日志**

查看tomcat目录下得logs/localhost*.log文件

**实时输出日志信息**

用`sh catalina.sh run`来运行tomcat



