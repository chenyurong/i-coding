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

-- 交叉连接
-- 显式交叉
select * from teacher t 
cross join course c;
-- 隐式交叉
select * from teacher t, course c;

-- 联合连接
select t.age from teacher t
union all
select c.age from course c;
 
 