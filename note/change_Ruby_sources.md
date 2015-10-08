# 改变Ruby gem源

因为国内墙的原因，所以当你用Ruby的gem命令安装一些插件时，会安装失败。这时候你可以通过改变gem源的方式解决问题，这里我们将gem源指向到淘宝备份在国内的gem镜像。

## 安装Ruby

Mac已自带，无需安装

## 改变ruby源

```
$ gem sources --remove https://rubygems.org/
$ gem sources -a https://ruby.taobao.org/
$ gem sources -l
*** CURRENT SOURCES ***

https://ruby.taobao.org
# 请确保只有 ruby.taobao.org
$ gem install rails
```

参考：http://ruby.taobao.org/

