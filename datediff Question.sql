/* write a SQL Query TO FIND BUSINESS DAY BETWEEN CREATE DATE AND RESOLVED DATE BY EXCLUDING WEEKENDS AND PUBLIC HOLIDAYS*/
create table leetcode.ticket
(
ticket_id varchar(10),
create_date date,
resolved_date date
);
insert into leetcode.ticket values
(1,'2022-08-01','2022-08-03')
,(2,'2022-08-01','2022-08-12')
,(3,'2022-08-01','2022-08-16');
create table leetcode.holidays
(
holiday_date date
,reason varchar(100)
);
insert into leetcode.holidays values
('2022-08-11','Rakhi'),('2022-08-15','Independence day');

select *
from leetcode.ticket;

select *
from leetcode.holidays;

SELECT 
    *, 
    DATEDIFF(resolved_date, create_date) AS difference_in_days,
    WEEK(resolved_date, 1) AS weekend_date, -- Week number using ISO-8601 standard
    WEEK(create_date, 1) AS weekstart_date, -- Week number using ISO-8601 standard
    -- Calculating the difference in week numbers
    WEEK(resolved_date, 1) - WEEK(create_date, 1) AS week_diff,
    -- Calculating business days excluding weekends
    DATEDIFF(resolved_date, create_date) 
    - (2 * (WEEK(resolved_date, 1) - WEEK(create_date, 1))) AS business_days
FROM 
    leetcode.ticket;
    
select *
from leetcode.holidays;

select ticket_id, create_date, resolved_date,count(holiday_date),
    WEEK(resolved_date, 1) - WEEK(create_date, 1) AS week_diff,datediff(resolved_date,create_date) as days,DATEDIFF(resolved_date, create_date) 
    - (2 * (WEEK(resolved_date, 1) - WEEK(create_date, 1)))-count(holiday_date) AS business_days
from leetcode.ticket
left join leetcode.holidays on holiday_date between create_date and resolved_date
group by ticket_id, create_date,resolved_date;



 
