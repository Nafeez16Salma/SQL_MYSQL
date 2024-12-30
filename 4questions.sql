/* Game Play Analysis 1,2,3,4

--q1 Write an SQL query that reports the first login date for each player
--q2 Write a SQL query that reports the device that is first logged in for each player
--q3 write a SQL query that reports for each player and date, how many games played so far by the player
that is , the total number of games played by the player until that dte
--q4 Write a SQL Query that reports the fraction of players that logged in again
--on the day after they first logged in, rounded to 2 decimal places*/

create table leetcode.activity (
 player_id  int,
 device_id  int,
 event_date date,
 games_played  int
 );

 insert into leetcode.activity values 
 (1,2,'2016-03-01',5 ),
 (1,2,'2016-03-02',6 ),
 (2,3,'2017-06-25',1 ),
(3,1,'2016-03-02',0 ),
(3,4,'2018-07-03',5 );

 
select * from leetcode.activity;

/*Write an SQL query that reports the first login date for each player*/

select player_id, min(event_date) as min_date
from leetcode.activity
group by player_id;
/*Write a SQL query that reports the device that is first logged in for each player*/
with cte as(
select player_id, min(event_date) as min_date
from leetcode.activity
group by player_id)

select player_id,device_id
from (
select a.player_id, device_id,event_date,c.min_date
from leetcode.activity a
inner join cte c
on a.player_id =  c.player_id
) b
where event_date = min_date;


/*write a SQL query that reports for each player and date, how many games played so far by the player
that is , the total number of games played by the player until that date*/

select player_id, sum(games_played) over (partition by player_id order by event_date) as running_sum
from leetcode.activity;

 /*Write a SQL Query that reports the fraction of players that logged in again
on the day after they first logged in, rounded to 2 decimal places */

use leetcode;
WITH ranked_events AS (
    SELECT
        player_id,
        event_date,
        LEAD(event_date) OVER (PARTITION BY player_id ORDER BY event_date) AS next_event_date
    FROM
        leetcode.activity
)
SELECT
    player_id,
    event_date,
    next_event_date,
    CASE 
        WHEN next_event_date = DATE_ADD(event_date, INTERVAL 1 DAY) THEN 1
        ELSE 0
    END AS next_date
FROM
    ranked_events
ORDER BY
    player_id,
    event_date;
