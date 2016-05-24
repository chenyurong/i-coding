## 配置 ssh key

在生成 ssh key 之前，先检查用户目录下是否有`.ssh`文件夹，如果有并且里面有类似`id_rsa,id_rsa.pub`文件，就说明之前已经生成过密钥，你可以选择使用原来的密钥，也可以重新生成新的密钥。

### 生成ssh key

打开`gitbash`执行下面命令：

```bash
ssh-keygen -t rsa -C "youremail"
``` 

其中`youremail`只是一个关键字，你也可以不用输入你的邮箱，而输入另外的字符。关于这个关键字，我推荐的命名格式为：`LOCATION_MACHINE_SERVER_SERVERACCOUNT`。

- LOCATION：表示地点。
- MACHINE：表示机器。
- SERVER：表示要连接到的服务器。
- SERVERACCOUNT：服务器账户名。

例如我在家用我的MAC连接到GitHub上，我在GitHub的账号是`hello@foxmail.com`，那么我将采用这个命名：`HOME_MAC_GITHUB_hello@foxmail.com`。

运行完ssh-keygen指令后，会提示你输入你的public key名称，这个名称推荐使用如下格式：`id_rsa_SERVER`。因为这里我用这个公钥来连接GitHub，所以我这里输入：id_rsa_github。之后会提示你输入使用公钥的密码，我们这里直接按Enter键不进行设置，之后会要求你进行确认，再次输入Enter键忽略即可。

运行完之后会在`~/.ssh/`目录下生成`id_rsa_github`和`id_rsa_github.pub`文件。用文本编辑器将`id_rsa_github.pub`中的内容复制一下粘贴到github(gitlab)上，即可完成公钥的配对。

### 添加私钥

添加了公钥之后，我们还需要在本机上进行私钥的设置。

运行下面的命令将`id_rsa_github`私钥添加到本地的`ssh-agent`中。

```bash
ssh-add ~/.ssh/id_rsa_github
```

如果执行ssh-add时提示“Could not open a connection to your authentication agent”，可以现执行命令启动ssh-agent程序：

```bash
$ ssh-agent bash
```

添加私钥后，我们可以通过`ssh-add -l`命令来查看私钥库中已经添加的私钥列表：

```bash
$ ssh-add -l
2048 SHA256:HyHjmSCWJCi+cQ9zO2r42L0aqvB814GAdw875FKUk9k id_rsa (RSA)
2048 SHA256:JbyD1arrouDbz6jSFVJ449fAdCp2XryEy4qkXa6eJhs id_rsa_github (RSA)
```

### 修改配置文件

在 ~/.ssh 目录下新建一个config文件，并添加下面的内容：

```file
# GitHub
Host github.com
        HostName www.github.com
        IdentityFile ~/.ssh/id_rsa_github
```

- Host：表示当ssh的时候如果server的URL能match上这里Host指定的值，则Host下面指定的HostName将被作为最终URL使用。一般建议和HostName相同。
- HostName：表示ssh连接的服务器地址，可以是域名也可以是IP地址。
- Port：ssh服务器开放端口。
- IdentityFile：表示使用那个私钥。

### 测试

输入下面的命令可以测试与ssh服务器的联通情况：

```
$ ssh -T git@github.com
Hi [username]! You've successfully authenticated, but GitHub does not provide shell access.
```

如果向上面一样出现提示信息，那么就说明连接成功了。

如果连接出现错误，你可以用`ssh -vT git@github.com`查看ssh连接的更详细信息。

## 配置多个ssh-key

其实配置多个ssh-key就是把上面的步骤重新来一遍，只不过每次配置的信息不能重复，仅此而已。配置多个ssh key的重点在于生成ssh key的时候和配置config文件的时候使用良好的命名格式，将不同的ssh key区分开来。

## 常见问题

**用`ssh -vT`命令测试通过了，但是为什么我还是不能从远程库clone项目？**   
如果仔细检查了配置的ssh服务器地址和端口等信息无误后，还是出现这个问题，以我的经验来说，很可能是密钥出现了问题。这个时候你可以删除对应的密钥和公钥，重头开始进行密钥配置。

**有没有更多的常见问题列表？**   
GitHub官方有一个常见问题列表，里面列举了许多ssh-key的常见错误，虽然是英文，但是用词非常简单，很容易看懂。传送门：[GitHub：Help](https://help.github.com/categories/ssh/)

参考资料：
   
[1.关于Linux系统中ssh配置文件1](http://book.51cto.com/art/200906/126284.htm)   
[2.关于Linux系统中ssh配置文件2](http://www.xuebuyuan.com/414672.html)
[3.ssh-agent和ssh-add命令1](http://man.linuxde.net/ssh-agent)   
[4.ssh-agent和ssh-add命令2](http://man.linuxde.net/ssh-add)

