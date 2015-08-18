# 为图形化IDE配置环境变量

在Win下只需要设置好系统变量，IDE启动时便会自动读取。但OSX系统下为图形化的IDE设置环境变化就稍微麻烦一些。

网上有许多种设置的方式，如：

- /etc/paths
- ~/.profile
- ~/.tcshrc

但是上面这些方式在最新的OSX系统都无法正常运行（OS X Yosemite 10.10.2）。经过实验，创建`/etc/launchd.conf`可以解决这个问题。

1. 打开命令行，并输入`sudo vim /etc/launchd.conf`（文件可能还未存在）
2. 在`launchd.conf`中填入以下内容

```
# Set environment variables here so they are available globally to all apps
# (and Terminal), including those launched via Spotlight.
#
# After editing this file run the following command from the terminal to update # environment variables globally without needing to reboot.
# NOTE: You will still need to restart the relevant application (including
# Terminal) to pick up the changes!
# grep -E "^setenv" /etc/launchd.conf | xargs -t -L 1 launchctl
#
# See http://www.digitaledgesw.com/node/31
# and http://stackoverflow.com/questions/135688/setting-environment-variables-in-os-x/
#
# Note that you must hardcode the paths below, don't use enviroment variables.
# You also need to surround multiple values in quotes, see MAVEN_OPTS example below.
#
setenv JAVA_VERSION 1.6 
setenv JAVA_HOME /System/Library/Frameworks/JavaVM.framework/Versions/1.6/Home 
setenv GROOVY_HOME /Applications/Dev/groovy setenv GRAILS_HOME /Applications/Dev/grails 
setenv NEXUS_HOME /Applications/Dev/nexus/nexus-webapp 
setenv JRUBY_HOME /Applications/Dev/jruby 
setenv ANT_HOME /Applications/Dev/apache-ant 
setenv ANT_OPTS -Xmx512M 
setenv MAVEN_OPTS "-Xmx1024M -XX:MaxPermSize=512m” 
setenv M2_HOME /Applications/Dev/apache-maven 
setenv JMETER_HOME /Applications/Dev/jakarta-jmeter
```

3. 保存修改，然后重启电脑。或者你可以运行上面代码注释里说到的`grep..`命令使设置生效
4. 打开命令行，输入`export`，确保你设置的参数都生效了。

NOTE：当你通过Spotlight启动图形化的IDE应用时，你在这里设置的环境变量也是有效的。



参考资料：   
[1].[http://stackoverflow.com/questions/135688/setting-environment-variables-in-os-x](http://stackoverflow.com/questions/135688/setting-environment-variables-in-os-x)
