/*write a SQL query to find the median of each company*/

create table leetcode.employ 
(
emp_id int,
company varchar(10),
salary int
);

insert into employ values 
(1,'A',2341),
(2,'A',341),
(3,'A',15),
(4,'A',15314),
(5,'A',451),
(6,'A',513),
(7,'B',15),
(8,'B',13),
(9,'B',1154),
(10,'B',1345),
(11,'B',1221),
(12,'B',234),
(13,'C',2345),
(14,'C',2645),
(15,'C',2645),
(16,'C',2652),
(17,'C',65);

select *
from leetcode.employ;

WITH rank_value AS (
    SELECT 
        emp_id,
        company,
        salary,
        ROW_NUMBER() OVER (partition by company order BY salary) AS row_num,
        COUNT(*) OVER (partition by company) AS total_rows
    FROM leetcode.employ
)
SELECT 
    emp_id,
    company,
    salary,
    row_num
FROM rank_value
WHERE row_num IN (
    FLOOR((total_rows + 1) / 2),
    CEIL((total_rows + 1) / 2)
)
ORDER BY row_num;

