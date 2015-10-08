# Maven整合Struts/Spring/Hibernate

开发环境：

**IDE**：IntelJ IDEA

**OS**：Wins7

# 1. Struts 框架支持

## 1.1 所需Jar包分析

|Jar包名|作用|是否必须|
|commons-fileupload.jar|用于文件上传|必须|
|commons-io.jar|用于IO操作|必须|
|commons-lang3.jar|包含通用一些操作|必须|
|freemarker.jar|模板相关操作需要包|必须|
|javassist.jar|编辑Java字节码的类库|必须|
|ognl.jar|ognl表达式所需包|必须|
|struts2-core.jar|struts2核心包|必须|
|xwork-core.jar|xwork核心包|必须|
|commons-logging.jar|用于struts的日志记录|非必须|
|struts2-convention-plugin.jar|用于struts注解|非必须|
|struts2-spring-plugin.jar|用于整合Spring框架|非必须|

## 1.2 Maven依赖

使用Maven加入上述包的依赖，只需要加入一个`struts-core`的依赖即可，因为其他包都是struts-core的直接或间接依赖。

```xml
<dependency>
          <groupId>org.apache.struts</groupId>
          <artifactId>struts2-core</artifactId>
          <version>2.3.16.1</version>
          <!--
            这里的exclusions是排除包，因为Struts2中有javassist，Hibernate中也有javassist, 所以如果要整合Hibernate，一定要排除掉Struts2中的javassist，否则就冲突了。
            <exclusions>
                <exclusion>
                    <groupId>javassist</groupId>
                    <artifactId>javassist</artifactId>
                </exclusion>
            </exclusions>-->
      </dependency>
```

如果要加入其他依赖，如：struts日志、Struts注解，则自己再加上对应的Maven依赖。可以通过这里查询：[查询Jar包对应的依赖声明](http://mvnrepository.com/search?q=)。我们这里再加上一个Struts注解的依赖：





