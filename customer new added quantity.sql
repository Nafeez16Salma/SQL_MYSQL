CREATE TABLE leetcode.sale 
(
    order_date date,
    customer VARCHAR(512),
    qty INT
);

INSERT INTO leetcode.sale  VALUES 
('2021-01-01', 'C1', '20'),
('2021-01-01', 'C2', '30'),
('2021-02-01', 'C1', '10'),
('2021-02-01', 'C3', '15'),
('2021-03-01', 'C5', '19'),
('2021-03-01', 'C4', '10'),
('2021-04-01', 'C3', '13'),
('2021-04-01', 'C5', '15'),
('2021-04-01', 'C6', '10');
select order_date, count(distinct customer) as count_new_customer from(
select *, 
row_number() over (partition by customer order by order_date) as rn
from leetcode.sale) a
where rn = 1
group by order_date;
