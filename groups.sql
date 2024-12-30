create table leetcode.stadium (
id int,
visit_date date,
no_of_people int
);

insert into leetcode.stadium values 
(1,'2017-07-01',10)
,(2,'2017-07-02',109)
,(3,'2017-07-03',150)
,(4,'2017-07-04',99)
,(5,'2017-07-05',145)
,(6,'2017-07-06',1455)
,(7,'2017-07-07',199)
,(8,'2017-07-08',188);

select *
from leetcode.stadium;
with cte as(
select *, row_number() over (order by visit_date) ordering,
id - row_number() over (order by visit_date) as grp
from leetcode.stadium
where no_of_people > 100
)
select *
from cte
where grp in
(select grp
from cte
group by grp
having count(1)>=3)