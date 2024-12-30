/*write a query to print the highest and lowest salary emp in each dept*/
create table leetcode.employee 
(
emp_name varchar(10),
dep_id int,
salary int
);

insert into leetcode.employee values 
('Siva',1,30000),
('Ravi',2,40000),
('Prasad',1,50000),
('Sai',2,20000);
WITH cte AS (
    SELECT 
        emp_name,
        dep_id,
        salary,
        RANK() OVER (PARTITION BY dep_id ORDER BY salary DESC) AS rn_highest,
        RANK() OVER (PARTITION BY dep_id ORDER BY salary ASC) AS rn_lowest
    FROM 
        leetcode.employee
)

SELECT 
    dep_id,
    MAX(CASE WHEN rn_highest = 1 THEN emp_name END) AS highest_salary,
    MAX(CASE WHEN rn_lowest = 1 THEN emp_name END) AS lowest_salary
FROM 
    cte
GROUP BY 
    dep_id;

