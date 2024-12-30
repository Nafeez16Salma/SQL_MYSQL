/* write a SQL query to find the cancellation of requests with unbanned users
(both client and driver must not be banned) each day between "2013-10-01" and "2013-10-03". Round cancellation rate to two decimal places

The cancellation rate is computed by dividing the number of canceled(by client or driver) requests with unbaneed users by the 
total number of requests with unbanned users on that day*/

Create table leetcode.Trips 
(id int, client_id int,
 driver_id int, city_id int, 
 status varchar(50), 
 request_at varchar(50));
Create table leetcode.Users
 (users_id int, 
 banned varchar(50), 
 role varchar(50));

insert into leetcode.Trips values 
  ('1', '1', '10', '1', 'completed', '2013-10-01'),
 ('2', '2', '11', '1', 'cancelled_by_driver', '2013-10-01'),
 ('3', '3', '12', '6', 'completed', '2013-10-01'),
 ('4', '4', '13', '6', 'cancelled_by_client', '2013-10-01'),
 ('5', '1', '10', '1', 'completed', '2013-10-02'),
 ('6', '2', '11', '6', 'completed', '2013-10-02'),
('7', '3', '12', '6', 'completed', '2013-10-02'),
('8', '2', '12', '12', 'completed', '2013-10-03'),
 ('9', '3', '10', '12', 'completed', '2013-10-03'),
('10', '4', '13', '12', 'cancelled_by_driver', '2013-10-03');

insert into leetcode.Users values
 ('1', 'No', 'client'),
 ('2', 'Yes', 'client'),
('3', 'No', 'client'),
 ('4', 'No', 'client'),
 ('10', 'No', 'driver'),
('11', 'No', 'driver'),
('12', 'No', 'driver'),
('13', 'No', 'driver');

select *
from leetcode.Trips;

Select *
from leetcode.users;
WITH cte AS (
    SELECT 
        t.request_at,
        t.status,
        c.banned AS client_banned,
        d.banned AS driver_banned
    FROM 
        leetcode.trips t
    INNER JOIN 
        leetcode.users c ON t.client_id = c.users_id
    INNER JOIN 
        leetcode.users d ON t.driver_id = d.users_id
    WHERE 
        t.request_at BETWEEN '2013-10-01' AND '2013-10-03'
)
, cte1 AS (
    SELECT 
        request_at, 
        CASE 
            WHEN status = 'cancelled_by_driver' OR status = 'cancelled_by_client' THEN 1 
            ELSE 0 
        END AS flag
    FROM 
        cte
    WHERE 
        client_banned = 'No' 
        AND driver_banned = 'No'
)
SELECT 
    request_at, 
    ROUND(SUM(flag) / COUNT(*), 2) AS ratio
FROM 
    cte1
GROUP BY 
    request_at
ORDER BY 
    request_at;
