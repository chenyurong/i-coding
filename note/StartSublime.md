[TOC]
# 开始使用Sublime

在开始使用Sublime之前，你需要先安装一些插件，这些插件可以让你事半功倍！

## 1. Package Control 插件

在Sublime中插件是以Package Control的形式存在的，`Package Control`件可以帮我们协助管理这些插件。

### 1.1 安装Package Control插件

`view` -> `showConsole`，打开命令输入窗口。输入以下命令：

```html
/* Sublime Text 2 */
import urllib2,os,hashlib; h = 'eb2297e1a458f27d836c04bb0cbaf282' + 'd0e7a3098092775ccb37ca9d6b2e4b7d'; pf = 'Package Control.sublime-package'; ipp = sublime.installed_packages_path(); os.makedirs( ipp ) if not os.path.exists(ipp) else None; urllib2.install_opener( urllib2.build_opener( urllib2.ProxyHandler()) ); by = urllib2.urlopen( 'http://packagecontrol.io/' + pf.replace(' ', '%20')).read(); dh = hashlib.sha256(by).hexdigest(); open( os.path.join( ipp, pf), 'wb' ).write(by) if dh == h else None; print('Error validating download (got %s instead of %s), please try manual install' % (dh, h) if dh != h else 'Please restart Sublime Text to finish installation')
/* Sublime Test 3 */
import urllib.request,os,hashlib; h = 'eb2297e1a458f27d836c04bb0cbaf282' + 'd0e7a3098092775ccb37ca9d6b2e4b7d'; pf = 'Package Control.sublime-package'; ipp = sublime.installed_packages_path(); urllib.request.install_opener( urllib.request.build_opener( urllib.request.ProxyHandler()) ); by = urllib.request.urlopen( 'http://packagecontrol.io/' + pf.replace(' ', '%20')).read(); dh = hashlib.sha256(by).hexdigest(); print('Error validating download (got %s instead of %s), please try manual install' % (dh, h)) if dh != h else open(os.path.join( ipp, pf), 'wb' ).write(by)
```

注意，不同Sublime版本输入内容不同。输入完成后Enter键确定，Sublime将自动完成安装，完成之后重启Sublime即可。

### 1.2 通过Package Control安装插件

`Package Control`不仅可以管理插件，还可以帮我们安装插件。虽然安装Sublime插件有很多种方式，但通过Package Control去安装插件是目前最方便也是最不容易出错的方式。

首先，用 `Ctrl + Shift + P` 调出搜索框，输入PCIP，选择“Package Control : Install Package”，之后输入插件名，选择对应插件。

## 2. Emmet 插件

Emmet插件可以帮我们快速编写HTML代码，提高我们的效率。

## 3. DocBlockr 插件

可以帮助我们生成JS函数的注解

## 4. SideBar Enhancements 插件 

这个插件改进了侧边栏，增加了许多功能：将文件移入回收站，在浏览器中浏览，将文件复制到剪切板。但目前Package Control中已无法搜索到

## 5. Sublime CodeIntel 插件

代码智能提醒插件，提供了很多IDE提供的功能，例如代码自动补齐，快速跳转到变量定义，在状态栏显示函数快捷信息等。它支持的语言有：PHP, Python, RHTML, JavaScript, Smarty, Mason, Node.js, XBL, Tcl, HTML, HTML5, TemplateToolkit, XUL, Django, Perl, Ruby, Python3.

虽然有时候有点小问题，但真的能节省很多时间。强烈推荐安装。

## 6. Markdown Preview 插件

可以提供Markdown文件格式的预览功能。   

安装好Markdown Preview插件后，快捷键`Ctrl + Shift + P`输入`MPPIB`搜索，选择Markdown Preview:Preview In Browse。

## 7.其他插件

###　7.1 Dayle Rees颜色主题

尽管Sublime自带的颜色主题已经够棒了，但也有审美疲劳的一天，这时，你可以下载Dayle Rees主题，有多款主题可选。

### 7.2 Sublime Linter

这个插件帮你找到代码中的错误。它支持很多语言：PHP, Python, Java, CoffeScript, CSS, HTML, JavaScript, Perl, PHP, Python, Ruby, XML等。Javascript需要安装Node.js引擎，其他配置详见项目主页。强烈推荐安装。

### 7.3 JSLint

JSLint是一个Javascript代码质量检测工具。它可以告诉你代码的什么地方需要改进。虽然你也可以在网上检测，但这个插件能让你不打开浏览器，直接在Sublime里面检测。

**使用方法**

按下`Shift + Command + P(Mac)`或是`Shift + Ctrl + P(Windows)`调出命令面板，找到`JSLint: Run JSLint`，按下`Enter`，JSLint会输出结果到状态栏。

### 7.4 Git

Git是我最喜欢的版本控制系统，如果你每天要使用Git，那这个插件对你来说必不可少了。

使用Package Control下载后，你只需要调出命令面板，输入Git，便能找到所有常用的功能。

### 7.5JSFormat

JS格式化插件