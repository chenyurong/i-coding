<!-- MarkdownTOC -->

- [Log4J 配置](#log4j-配置)
    - [1. 引入依赖](#1-引入依赖)
    - [2. 配置 log4j.properties 文件](#2-配置-log4jproperties-文件)
    - [3. 使用 Log4J 记录日志](#3-使用-log4j-记录日志)

<!-- /MarkdownTOC -->

# Log4J 配置

## 1. 引入依赖

```xml
<dependency>
    <groupId>log4j</groupId>
    <artifactId>log4j</artifactId>
    <version>1.2.17</version>
</dependency>
```

## 2. 配置 log4j.properties 文件

log4j.properties 文件要放在资源目录下，默认是src目录。

```xml
# Console Log
log4j.rootLogger=info, console, file

# Write to Console
log4j.appender.console=org.apache.log4j.ConsoleAppender
log4j.appender.console.Threshold=INFO
log4j.appender.console.layout=org.apache.log4j.PatternLayout
log4j.appender.console.layout.ConversionPattern=%5p %d{MM-dd HH:mm:ss}(%F:%L): %m%n

# Write to File
log4j.appender.file=org.apache.log4j.DailyRollingFileAppender
log4j.appender.file.File=${catalina.home}app/log/log.log
log4j.appender.file.layout=org.apache.log4j.PatternLayout
log4j.appender.file.layout.ConversionPattern=%5p %d{MM-dd HH:mm:ss}(%F:%L): %m%n
```

上面的配置文件中配置了输出info级别以上的信息，有console和file两个输出。console输出到控制台，file输出到 ${catalina.home}/app/log/log.log 文件，其中${catalina.home}指的是项目的根目录。

NOTE：更详细的配置文件配置信息，可以参考[这里](http://www.iteye.com/topic/378077)

## 3. 使用 Log4J 记录日志

到这里，配置方面已经完成了，接下来就可以在代码中进行日志记录了。在代码中进行日志记录一般只需要在代码中声明取得一个Log对象，之后再任意位置调用logger对象的方法即可。

```java
public class UserAction extends ActionSupport {
	// 1. 取得Log对象
    private Log logger = LogFactory.getLog(UserAction.class);
    ……

    public String login(){
    	// 2. 使用Log对象记录日志
        logger.info("【" + username + "】trying to login.");
        ……
    }
```  

至此，Log4J配置完成，是不是挺简单的呢。


