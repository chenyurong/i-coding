# Mac下同时安装多个版本的JDK

JDK8 GA之后，小伙伴们喜大普奔，纷纷跃跃欲试，想体验一下Java8的Lambda等新特性，可是目前Java企业级应用的主打版本还是JDK6， JDK7。因此，我需要在我的电脑上同时有JDK8，JDK7，JDK6。JDK6和JDK7主要是做一些产品代码的验证，以及自己玩一些开源项目，JDK8则纯属尝鲜，谁叫咱是喜新厌旧的程序员呢。 

## 目标 

在命令行下，可以通过命令'jdk6', 'jdk7','jdk8'轻松切换到对应的Java版本， 默认初始设置为jdk7。 

## 做法 

1. 首先安装所有的JDk： 

* Mac自带了的JDK6，安装在目录：`/System/Library/Java/JavaVirtualMachines/1.6.0.jdk/`下。 

* JDK7，JDK8则需要自己到Oracle官网下载安装对应的版本。自己安装的JDK默认路径为：`/Library/Java/JavaVirtualMachines/jdk1.8.0.jdk `

2. 在用户目录下的bash配置文件.bashrc中配置JAVA_HOME的路径： 

```
export JAVA_6_HOME=/System/Library/Java/JavaVirtualMachines/1.6.0.jdk/Contents/Home
export JAVA_7_HOME=/Library/Java/JavaVirtualMachines/jdk1.7.0.jdk/Contents/Home
export JAVA_8_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0.jdk/Contents/Home
export JAVA_HOME=$JAVA_7_HOME
```

3.创建alias命令动态切换JAVA_HOME的配置 

将以下命令添加到`/etc/profile`中，为所有用户添加命令别名：

```
alias jdk8='export JAVA_HOME=$JAVA_8_HOME'
alias jdk7='export JAVA_HOME=$JAVA_7_HOME'
alias jdk6='export JAVA_HOME=$JAVA_6_HOME'
```

4. 验证

```
CNxnliu:Versions xnliu$ java -version
java version "1.6.0_65"
Java(TM) SE Runtime Environment (build 1.6.0_65-b14-462-11M4609)
Java HotSpot(TM) 64-Bit Server VM (build 20.65-b04-462, mixed mode)
CNxnliu:Versions xnliu$ jdk8
CNxnliu:Versions xnliu$ java -version
java version "1.8.0"
Java(TM) SE Runtime Environment (build 1.8.0-b132)
Java HotSpot(TM) 64-Bit Server VM (build 25.0-b70, mixed mode)
CNxnliu:Versions xnliu$
```

参考资料：
[1].[http://ningandjiao.iteye.com/blog/2045955](http://ningandjiao.iteye.com/blog/2045955)