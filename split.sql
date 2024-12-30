create table leetcode.input (
id int,
formula varchar(10),
value int
);
insert into leetcode.input values 
(1,'1+4',10),
(2,'2+1',5),
(3,'3-2',40),
(4,'4-1',20);



with cte as(
select *, 
left(formula,1) as d1, right(formula,1) as d2, substring(formula,2,1) as o
from leetcode.input)

select cte.id, cte.value,cte.o, cte.formula,cte.o,ip1.value as d1_value,ip2.value as d2_value,
case when cte.o = '+' then ip1.value+ip2.value
else ip1.value - ip2.value end as result
from cte
inner join leetcode.input ip1 on cte.d1=ip1.id
inner join leetcode.input ip2 on cte.d1=ip2.id