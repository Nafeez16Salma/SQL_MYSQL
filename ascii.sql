CREATE TABLE leetcode.employees  
(employee_id int,
employee_name varchar(15),
 email_id varchar(15) );

INSERT INTO leetcode.employees VALUES
('101','Liam Alton', 'li.al@abc.com'),
('102','Josh Day', 'jo.da@abc.com'),
('103','Sean Mann', 'se.ma@abc.com'),
('104','Evan Blake', 'ev.bl@abc.com'),
('105','Toby Scott', 'jo.da@abc.com'),
('106','Anjali Chouhan', 'JO.DA@ABC.COM'),
('107','Ankit Bansal', 'AN.BA@ABC.COM');

WITH cte AS (
    SELECT 
        *, 
        ASCII(SUBSTRING(email_id, 1, 1)) AS ascii_value, 
        RANK() OVER (PARTITION BY email_id ORDER BY ASCII(SUBSTRING(email_id, 1, 1)) DESC) AS rank_email
    FROM leetcode.employees
)
SELECT * FROM cte
where rank_email = 1;



