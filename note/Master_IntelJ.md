# IntelJ

## IntelJ快捷键

|快捷键|作用|
|---|---|
|ctrl+shift+space|自动提示| 
|ctrl+shift+/|多行注释|
|ctrl+e|查看所有文件|
|ctrl+shift+v|查看粘贴板*|
|alt+shift+c|最近变更历史|
|ctrl+shift+i|快速查看实现|

|************|************|
|填充代码类|************|
|ctrl+alt+t|自动生成if/else try/catch等|
|ctrl+shift+enter|智能完善代码 如 if()|
|************|************|
|ctrl+alt+s|设置窗口|



|************|************|
|自定义快捷键|************|
|Alt+T|显示/隐藏工具栏(Toolbar)|
|Alt+F|进入/退出全屏(Enter Full Screen)|
|Alt+S|显示/隐藏状态栏(Status Bar)|
|Alt+B|显示/隐藏工具按钮(Tool Buttons)|    
|Alt+N|显示/隐藏导航栏(Navigation Bar)|

	

|************|************|
|编辑类|************|
|ctrl+shift+up/down|移动行、合并选中行|
|ctrl+up/down|页面向上/下滑动一行|
|Ctrl+D|复制本行到下一行|
|Ctrl+Y|删除本行|
|Alt+/|复制上一单词|
|Ctrl+O|重写父类方法|

|Shift+Enter|光标从任意位置跳到下一行|
|ctrl+alt+l|格式化代码|
|Alt+Delete|安全删除字段或方法|
|Alt+up/down|跳到上一个/下一个方法或属性|






## Ctrl+Alt+N

Ctrl+Alt+N:把一些方法或变量赋值放在这，可以去除一些多余的赋值过程，这在重构中会非常常用，用法如下：

```
public String doGetString(String name) {
        return String.format("your name:%s" + name);
    }
    public void function() {
        String zahngsan = doGetString("zhangsan");
}
```