## 创建GitBook

`README.md`和`SUMMARY.md`是Gitbook项目必备的两个文件，也就是一本最简单的gitbook也必须含有这两个文件，它们在一本Gitbook中具有不同的用处。

### 创建README.md

`README.md`文件将会作为首页显示

### 创建SUMMARY.md

这个文件是一本书的目录结构，使用Markdown语法，如我们这本书的`SUMMARY.md`：

```
* [基本安装](howtouse/README.md)
 - [Node.js安装](howtouse/Nodejsinstall.md)
 - [Gitbook安装](howtouse/gitbookinstall.md)
 - [Gitbook命令行速览](howtouse/gitbookcli.md)
* [图书项目结构](book/README.md)
 - [README.md 与 SUMMARY编写](book/file.md)
 - [目录初始化](book/prjinit.md)
* [图书输出](output/README.md)
 - [输出为静态网站](output/outfile.md)
 - [输出PDF](output/pdfandebook.md)
* [发布](publish/README.md)
 - [发布到Github Pages](publish/gitpages.md)
* [结束](end/README.md)
```

### 目录初始化

当这个目录文件创建好之后，我们可以使用Gitbook的命令行工具将这个目录结构生成相应的目录及文件：

```
$ gitbook init
$ ls
LICENSE    SUMMARY.md book       output
README.md      howtouse   publish
$ tree .
.
├── LICENSE
├── README.md
├── SUMMARY.md
├── book
│   ├── README.md
│   ├── file.md
│   └── prjinit.md
├── howtouse
│   ├── Nodejsinstall.md
│   ├── README.md
│   ├── gitbookcli.md
│   └── gitbookinstall.md
├── output
│   ├── README.md
│   ├── outfile.md
│   └── pdfandebook.md
└── publish
    ├── README.md
    └── gitpages.md
```

我们可以看到，gitbook给我们生成了与`SUMMARY.md`所对应的目录及文件。

每个目录中，都有一个`README.md`文件，相当于一章的说明。

### 输出为静态网站

**本地预览时自动生成**

当你在自己的电脑上编辑好图书之后，你可以使用Gitbook的命令行进行本地预览：

```
$ gitbook serve ./图书目录
```

你可以你的浏览器中打开这个网址：`http://localhost:4000`

这里你会发现，你在你的图书项目的目录中多了一个名为_book的文件目录，而这个目录中的文件，即是生成的静态网站内容。

### Tips

一般我用他把自己的GitBook笔记生成静态站点。

首先，我会将`book.json`、`SUMMARY.md`复制到根目录。

```book.json
{
  "gitbook": ">=2.0.0",
  "title":"wechat Notebook",
  "language":"zh-cn",
  "description":"微信公众号开发全记录"
}
```

之后用`gitbook serve ./图书目录`生成静态文件。在根目录添加`.gitignore`文件，忽略生成的`_book`文件夹：

```.gitignore
#忽略_book文件
_book
```

最后将生成的静态html文件拷贝到`gh-pages`分支中，最后提交到GitHub中。


