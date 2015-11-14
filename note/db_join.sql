-- 1、内连接
-- 显式内连接
-- 写法1
select 
    t.id, t.name, c.teacherId, c.id, c.name
from
    teacher t
        inner join
    course c ON t.id = c.teacherId;
-- 写法2
select 
    t.id, t.name, c.teacherId, c.id, c.name
from
    teacher t
        join
    course c ON t.id = c.teacherId;
-- 隐式内连接
select 
    t.id, t.name, c.teacherId, c.id, c.name
from teacher t, course c
where t.id = c.teacherId;


-- 2、外连接
-- 左外连接
select 
    t.id, t.name, c.teacherId, c.id, c.name
from
    teacher t
        left outer join
    course c ON t.id = c.teacherId;
-- 右外连接
select 
    t.id, t.name, c.teacherId, c.id, c.name
from
    teacher t
        right outer join
    course c ON t.id = c.teacherId;
-- 全外连接（MYSQL不支持，但可以用UNION解决）
-- 理论上的全外连接
select 
	t.id, t.name, c.teacherId, c.id, c.name
from teacher t
		full outer join
	course c on t.id = c.teacherId; 
-- 用UNION实现全外连接
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

-- 3、联合连接
select t.age from teacher t
union all
select c.age from course c;

-- 4、交叉连接
-- 显式交叉
select * from teacher t 
cross join course c;
-- 隐式交叉
select * from teacher t, course c;

 
 