# 数据库的连接查询

数据库连接查询是数据库查询非常重要的一个知识点，我们经常可以听到如：

- 左外连接、右外连接、全外连接
- 内连接
- 笛卡尔积、全连接等，我相信许多人都分不清楚他们的区别。

今天我们将详细介绍这几种连接方法的用法，并给出详细的例子。希望能借此帮大家分清这几种连接方式的区别。

其实数据库的各种连接大致分为以下四种：

- 内连接
- 外连接（左外连接、右外连接、全外连接）
- 联合连接
- 交叉连接

首先我们创建两个表：teacher表和course表，分别往里面插入一些数据：

```
//teacher表
//  id   name       age
    1   Tommy       20
    2   Jackson     50
    3   Catalina    33
    4   Steve       26
    5   Stephen     28
//course表
//  id  name	teacherId   age
    1   math        1       20
    2   chinese     2       30
    3   physical    3       23
    4   chemiscal   6       44
```

## 内连接 

内连接（INNER JOIN）有两种形式，一种是显式内连接，一种是隐式内连接。内连接会显示两边都匹配的记录。

```
//显式内连接
//写法1
select 
    t.id, t.name, c.teacherId, c.id, c.name
from
    teacher t
        inner join
    course c ON t.id = c.teacherId;
//写法2
select 
    t.id, t.name, c.teacherId, c.id, c.name
from
    teacher t
        join
    course c ON t.id = c.teacherId;
//隐式内连接
select 
    t.id, t.name, c.teacherId, c.id, c.name
from teacher t, course c
where t.id = c.teacherId;
```

运行结果：

```
1	Tommy		1	1	math
2	Jackson		2	2	chinese
3	Catalina	3	3	physical
```

其实隐式内连接就是普通的where语句。上面这3种方式的运行结果都是相同的。其中显式内连接的inner是可以省略的。

## 外连接

外连接分为：
- 左外连接（left outer join）
- 右外连接（right outer join）
- 全外连接（完全连接  full outer join）

其中outer关键字是可以省略的。

### 左外连接（left outer join）

左外连接将会显示左边表所有记录，而右边表没有匹配到的记录则用null表示。

```
select 
    t.id, t.name, c.teacherId, c.id, c.name
from
    teacher t
        left outer join
    course c ON t.id = c.teacherId;
```

运行结果：

```
1	Tommy		1	1	math
2	Jackson		2	2	chinese
3	Catalina	3	3	physical
4	Steve			
5	Stephen			
```

可以看到教师名为Steve/Stephen的记录中，因为在course中没有对应的记录，所以course表的记录数据用null显示。

### 右外连接（right outer join）

跟左外连接相反。右外连接将会显示右边表所有记录，而左边表没有匹配到的记录则用null表示。 

```
select 
    t.id, t.name, c.teacherId, c.id, c.name
from
    teacher t
        right outer join
    course c ON t.id = c.teacherId;
```

运行结果如下：

```
1	Tommy		1	1	math
2	Jackson		2	2	chinese
3	Catalina	3	3	physical
				6	4	chemiscal
```

可以看到课程名为chemiscal的课程教师编号为6，但teacher表中没有id编号为6的老师，因此用null表示。

### 全外连接（full outer join）

全外连接可以说是左外和右外的并集，所以它也叫完全连接。全外连接显示左右两边全部记录，当一边的记录在另一边无法匹配到时，用null表示。

```
select 
    t.id, t.name, c.teacherId, c.id, c.name
from teacher t
        full outer join
    course c on t.id = c.teacherId; 
```

运行结果:

```
1   Tommy       1   1   math
2   Jackson     2   2   chinese
3   Catalina    3   3   physical
                6   4   chemiscal
4   Steve           
5   Stephen         
```

MySQL数据库不支持全外连接，但是我们可以通过`UNION JOIN`联合连接来达到全外连接的效果。如下面的SQL语句运行结果与上面的结果是一样的。

```
select 
    t.id, t.name, c.teacherId, c.id, c.name
from
    teacher t
        right outer join
    course c ON t.id = c.teacherId
union
select 
    t.id, t.name, c.teacherId, c.id, c.name
from
    teacher t
        left outer join
    course c ON t.id = c.teacherId;
```

其实就是把左外和右外连接组合起来，去除相同的结果就是了。       

## 联合连接（UNION JOIN）

联合连接，即union join。联合连接将两个结果集组合起来并去除重复的记录，其中左边的结果集要与右边的结果集数据结构完全一样，即拥有列数和每一列的数据类型要一致。

这里我们向teacher表和course表增加一个age字段，然后执行下面这个语句：

```
select t.age from teacher t
union
select c.age from course c;
```

运行结果：

```
20
50
33
26
28
30
23
44
```

其实teacher中有age为20的老师，course中也有age为20的课程，但查询出来的结果集只有一个20的记录，这是因为union连接将重复的列去除了。如果需要保留重复的记录则使用`union all`关键字。

## 交叉连接（笛卡尔积）

交叉连接（cross join）也称笛卡尔积，它返回两个表中所有记录的交叉记录。即如果A表有5条记录，B表有4条记录，那么交叉连接则会返回4*5=20条记录。其中交叉连接（cross join）也有显式交叉连接和隐式交叉连接之分。

隐式交叉连接是一般的SQL查询去掉where语句，即：

```
select * from teacher t, course c
```

显式交叉连接是用`cross join`关键词，即：

```
select * from teacher t cross join course c;
```

## 总结

### 关于内连接

1、内连接（inner join）与where语句的效果完全一样，而且内连接inner关键字可以省略
2、外连接（full/left/right outer join）中的outer也可以省略
3、笛卡尔积（cross join）与没有条件的where语句是一样的，都是两个表记录的交叉。

有需要可以下载本文的[SQL文件](db_join.sql)