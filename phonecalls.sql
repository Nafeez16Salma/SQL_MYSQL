/* write a query to get start time and end time of each call from below 2 tables. also create a 
column of call duration in minutes. please do take into account that there will be multiple calls 
from one phone number and each entry in the start table has a corresponding entry in the end table*/
create table leetcode.call_start_logs
(
phone_number varchar(10),
start_time datetime
);
insert into leetcode.call_start_logs values
('PN1','2022-01-01 10:20:00'),
('PN1','2022-01-01 16:25:00'),
('PN2','2022-01-01 12:30:00'),
('PN3','2022-01-02 10:00:00'),
('PN3','2022-01-02 12:30:00'),
('PN3','2022-01-03 09:20:00');
create table leetcode.call_end_logs
(
phone_number varchar(10),
end_time datetime
);
insert into leetcode.call_end_logs values
('PN1','2022-01-01 10:45:00'),
('PN1','2022-01-01 17:05:00'),
('PN2','2022-01-01 12:55:00'),
('PN3','2022-01-02 10:20:00'),
('PN3','2022-01-02 12:50:00'),
('PN3','2022-01-03 09:40:00');

select *
from leetcode.call_start_logs;

select *
from leetcode.call_end_logs;

SELECT 
    a.phone_number, 
    a.start_time AS call_start_time, 
    b.end_time AS call_end_time, 
    TIMESTAMPDIFF(MINUTE, a.start_time, b.end_time) AS duration_in_minutes
FROM
(
    SELECT 
        phone_number, 
        start_time,
        ROW_NUMBER() OVER (PARTITION BY phone_number ORDER BY start_time) AS cs
    FROM 
        leetcode.call_start_logs
) a
INNER JOIN
(
    SELECT 
        phone_number, 
        end_time,
        ROW_NUMBER() OVER (PARTITION BY phone_number ORDER BY end_time) AS ce
    FROM 
        leetcode.call_end_logs
) b
ON a.phone_number = b.phone_number AND a.cs = b.ce;
