/* Get the Second most activity, if there is only one then we will take only one*/
create table leetcode.UserActivities
(
username      varchar(20) ,
activity      varchar(20),
startDate     Date   ,
endDate      Date
);

insert into leetcode.UserActivities values 
('Alice','Travel','2020-02-12','2020-02-20')
,('Alice','Dancing','2020-02-21','2020-02-23')
,('Alice','Travel','2020-02-24','2020-02-28')
,('Bob','Travel','2020-02-11','2020-02-18');

select *
from leetcode. useractivities;

with cte as(
select username,activity,rank() over (partition by username order by startdate desc) as count_username,count(1) over (partition by username) as total_activities
from leetcode.useractivities 
)
select username,activity
from cte
where count_username = 2 or total_activities = 1