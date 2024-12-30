/* A company wants to hire new employees. The budget of the company for the salaries is $70000. The company's criteria for hiring are:
keep hiring the senior with the smallest salary until you cannot hire any more seniors
Use the remaining budget to hire the junior with the smallest salary
keep hiring the junior with the smallest salary until you cannot hire any more juniors
write an SQL query to find the seniors and juniors hired under mentioned criteria*/

create table leetcode.candidates (
emp_id int,
experience varchar(20),
salary int
);

insert into leetcode.candidates values
(1,'Junior',10000),
(2,'Junior',15000),
(3,'Junior',40000),
(4,'Senior',16000),
(5,'Senior',20000),
(6,'Senior',50000);

select *
from leetcode.candidates;

WITH cte AS (
    SELECT 
        emp_id, 
        experience, 
        salary,
        SUM(salary) OVER (ORDER BY emp_id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_sum
    FROM 
        leetcode.candidates
    WHERE 
        experience = 'Senior'
),
filtered_seniors AS (
    SELECT 
        emp_id, 
        experience, 
        salary,
        running_sum
    FROM 
        cte
    WHERE 
        running_sum <= 70000
),
remaining_budget AS (
    SELECT 
        70000 - MAX(running_sum) AS budget
    FROM 
        filtered_seniors
),
juniorhired as(

select emp_id,
       experience,
       salary,
       sum(salary) over (order by emp_id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS Salary1
       from leetcode.candidates
       where experience = 'Junior' AND Salary <= (SELECT budget from remaining_budget)
       ),
	newtable as(
    select emp_id,experience,salary
    from filtered_seniors
	union all
    select emp_id,experience,salary
    from juniorhired)
    
    select *
    from newtable;