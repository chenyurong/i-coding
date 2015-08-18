## IntelJ13的一个bug

IntelJ13使用最新版本的Maven进行编译等操作时，会Maven会报以下错误：

```
-Dmaven.multiModuleProjectDirectory system propery is not set. Check $M2_HOM
```

这其实是IntelJ的一个bug，IntelJ所属公司JetBrain已经在14.0版本修复了这个bug。

在这里提供一种解决方案，虽然麻烦一点，但也可以将就用。

打开偏好设置，找到`Maven->Runner`选项，在`VM Options`填入：`-Dmaven.multiModuleProjectDirectory=$M2_HOME`


参考资料：   
[1].[https://youtrack.jetbrains.com/issue/IDEA-137783](https://youtrack.jetbrains.com/issue/IDEA-137783)
[2].[http://stackoverflow.com/questions/29153115/dmaven-multimoduleprojectdirectory-system-propery-is-not-set-check-m2-home-en](http://stackoverflow.com/questions/29153115/dmaven-multimoduleprojectdirectory-system-propery-is-not-set-check-m2-home-en)