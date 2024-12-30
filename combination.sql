create table leetcode.family 
(
person varchar(5),
type varchar(10),
age int
);

insert into leetcode.family values 
('A1','Adult',54),
('A2','Adult',53),
('A3','Adult',52),
('A4','Adult',58),
('A5','Adult',54),
('C1','Child',20),
('C2','Child',19),
('C3','Child',22),
('C4','Child',15);

with k as(
select *, row_number() over (order by age desc) as rn
from leetcode.family
where type = 'Adult')
,l as(
 select *, row_number() over (order by age asc) as rn
from leetcode.family
where type = 'Child')

select k.person,l.person
from k
left join l
on k.rn = l.rn;