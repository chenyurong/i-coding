# Java泛型

## 泛型的概念

泛型（Generic type 或者generics）是对 Java 语言的类型系统的一种扩展，以支持创建可以按类型进行参数化的类（比如我们可以创建List<String>、List<Integer>）。可以把类型参数看作是使用参数化类型时指定的类型的一个占位符，就像方法的形式参数是运行时传递的值的占位符一样。 

## 为什么要有泛型

在解释这个问题之前，我们先来看一个例子。

```java
List list = new ArrayList();
list.put("hello");
list.put("java");
list.put(12);
String str = (String)list.get(2);  //抛出ClassCastException
```

Map.get()被定义为返回Object，所以一般必须将map.get()的结果强制类型转换为期望的类型。但是有可能某人已经在该映射中保存了不是String的东西，这样的话，上面的代码将会抛出ClassCastException。 

于是一个问题出现了：如何限制存放在一个集合中的数据只能是一种类型的数据？

我们总不能把这种检查依赖于主观因素特别强的开发人员身上，让开发人员去记住他们存放了什么类型的数据吧。

于是在JDK1.5之后，Java引入了泛型的概念，限制了每个集合中只能存放一种类型的数据。上面的代码用泛型之后会是这样：

```java
List<String> list = new ArrayList<String>();
list.add("Hello");
String str = list.get(0);
```

当你试图向list集合中插入非String类型的时候，编译的时候就会报错。

## 泛型的好处

### 类型安全

有了泛型之后，我们可以保证插入集合中的数据只是某一种类型那个的数据，这极大地提高了Java程序的类型安全。通过泛型，我们可以让编译器知道我们要插入的额什么数据，让编译器帮助我们进行类型检查。没有泛型，这些假设就只存在于程序员的头脑中（或者如果幸运的话，还存在于代码注释中）。 例如上面的例子，在泛型中，是无法通过编译的：

```
List list = new ArrayList();
list.put("hello");
list.put("java");
list.put(12);	//编译不通过
```

### 消除强制类型转换

泛型的一个附带好处是，消除源代码中的许多强制类型转换。这使得代码更加可读，并且减少了出错机会。 

```
List<String> list = new ArrayList<String>();
list.add("Hello");
String str = list.get(0);   //无需强制类型转换
```

### 提高运行性能

在没有泛型的时候，程序会在运行的时候进行强制类型转换并且进行类型检查（如果不符合，则派出ClassCastException）。而在泛型实现之后，编译器会在编译期间进行类型检查，并且将符合类型约束的类型直接替换成对应的数据类型，并直接写入字节码文件中。

也就是说，其实泛型这个概念在程序运行期间是不存在的，它只存在于编译期间。通过这种方式，我们将类型检查和强制类型转换从运行期间移到了编译期间，以此提高了程序的运行性能。

## 泛型的实现原理

泛型通过占位符的形式告诉编译器，相同的占位符是同数据类型。而编译器在编译的时候就会从程序中读取我们输入的数据类型，并把集合中的占位符替换成我们输入的数据类型。

```java
public interface Map<K, V> { 
public void put(K key, V value); 
public V get(K key); 
} 
```

就像Map源码中所写一样，如果程序中声明的Map是`Map<K, V>`，那么你使用put方法的时候输入的数据类型必须就是`put(K key, V value)`。看看下面这个例子：

```java
Map<String, String> map = new HashMap<String, String>();
map.put("1", "Tom");
map.put("2", "marry");
map.put("3", "Tommy");
String name = map.get(0);
```

向上个这个例子所说的，我们声明了map是一个<String,String>类型的。当编译器编译到第一句的时候，编译器会将集合中的K/V占位符替换成String/String，也就是类似下面这样：

```java
public interface Map<String, String> { 
public void put(String key, String value); 
public String get(String key); 
} 
```

当我们往map中调用put方法插入"Tom"的时候，此时put方法的两个参数已经是String类型的了，编译器会检查数据类型是否是String类型。如果不是，编译器则会提示出错。

```java
public void put(String key, String value); 
```

而当我们使用get()方法取出数据的时候，get()方法自然返回String类型的数据，无需我们进行强制类型转换。

```
public String get(String key); 
```

注：这个说明只是一种比较形象的解释说明，实际上编译器的操作可能有些许不同。

## 其他关于泛型的知识点

### 泛型常用的几个变量（K/V/E/T/*）

- `K` —— 键，比如映射的键。 
- `V` —— 值，比如 List 和 Set 的内容，或者 Map 中的值。 
- `E` —— 异常类。 
- `T` —— 泛型。 
- `?` —— 类型通配符

### 类型约束

在一个类中，如果我们声明一个这样的方法：

```
public <T> T hello(boolean b, T first, T second) { 
return b ? first : second; 
} 
```

这表明所有的T都是必须是同一数据类型，这样就是类型约束。编译器不必显式地被告知 T 将具有什么值；它只知道这些值都必须相同。

你可以这样调用：

```
String s = hello(b, "a", "b");
```

类似地，你可以这样调用：

```
Integer i = hello(b, new Integer(1), new Integer(2)); 
```

但是编译器不允许下面的代码：

```
String s = hello(b, "pi", new Float(3.14)); 
```

### 有限制类型

在上面的例子中，类型参数V是无约束的或无限制的类型。有时在还没有完全指定类型参数时，需要对类型参数指定附加的约束。 

考虑例子School类，它使用类型参数V，该参数由Number类来限制： 

```java
public class School<V extends Number> { ... } 
```

`School<Integer>/School<Float>`可以正常定义。但是School<String>类型的变量，则会出现错误。类型参数V被判断为由Number限制。在没有类型限制时，假设类型参数由Object限制。

### 协变

关于泛型的混淆，一个常见的来源就是假设它们像数组一样是协变的。其实它们不是协变的。即List<Object>不是List<String>的父类型。

如果 A 扩展 B，那么 A 的数组也是 B 的数组，并且完全可以在需要B[]的地方使用A[]：

```java
Integer[] intArray = new Integer[10]; 
Number[] numberArray = intArray; 
```

上面的代码是有效的，因为一个Integer是一个Number，因而一个Integer数组是一个Number数组。但是对于泛型来说则不然。下面的代码是无效的：

```java
List<Integer> intList = new ArrayList<Integer>(); 
List<Number> numberList = intList; // invalid 
```

最初，大多数 Java 程序员觉得这缺少协变很烦人，或者甚至是“坏的（broken）”，但是之所以这样有一个很好的原因。如果可以将List<Integer>赋给List<Number>，下面的代码就会违背泛型应该提供的类型安全： 

```java
List<Integer> intList = new ArrayList<Integer>(); 
List<Number> numberList = intList; // invalid 
numberList.add(new Float(3.1415)); 
```

因为intList和numberList都是有别名的，如果允许的话，上面的代码就会误导您将不是Integers的东西放进intList中。

**参考资料**   
[http://www.cnblogs.com/yinhaiming/articles/1749738.html](http://www.cnblogs.com/yinhaiming/articles/1749738.html)

