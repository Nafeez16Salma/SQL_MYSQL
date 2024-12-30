create table leetcode.saless (
product_id int,
period_start date,
period_end date,
average_daily_sales int
);

insert into leetcode.saless values
(1,'2019-01-25','2019-02-28',100),
(2,'2018-12-01','2020-01-01',10),
(3,'2019-12-01','2020-01-31',1);

select *
from leetcode.saless;

WITH RECURSIVE r_cte AS (
    -- Anchor member: Start with the minimum period_start and maximum period_end
    SELECT MIN(period_start) AS dates, MAX(period_end) AS max_date
    FROM leetcode.saless
union all
SELECT DATE_ADD(dates, INTERVAL 1 DAY) AS dates, max_date
    FROM r_cte
    WHERE DATE_ADD(dates, INTERVAL 1 DAY) <= max_date

    -- Recursive member: Generate the next date until the max_date
    
)


SELECT 
    s.product_id,
    YEAR(r.dates) AS year,
    SUM(s.average_daily_sales) AS total_sales -- Example aggregation: Sum of sales amount
FROM leetcode.saless s
INNER JOIN r_cte r ON r.dates BETWEEN s.period_start AND s.period_end
GROUP BY s.product_id, YEAR(r.dates)
ORDER BY s.product_id, YEAR(r.dates);
