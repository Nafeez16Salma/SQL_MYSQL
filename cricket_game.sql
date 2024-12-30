create table leetcode.icc_world_cup
(
match_no int,
team_1 Varchar(20),
team_2 Varchar(20),
winner Varchar(20)
);
INSERT INTO leetcode.icc_world_cup values
(1,'ENG','NZ','NZ'),
(2,'PAK','NED','PAK'),
(3,'AFG','BAN','BAN'),
(4,'SA','SL','SA'),
(5,'AUS','IND','IND'),
(6,'NZ','NED','NZ'),
(7,'ENG','BAN','ENG'),
(8,'SL','PAK','PAK'),
(9,'AFG','IND','IND'),
(10,'SA','AUS','SA'),
(11,'BAN','NZ','NZ'),
(12,'PAK','IND','IND'),
(12,'SA','IND','DRAW');

select *
from leetcode.icc_world_cup;

WITH cte AS (
    SELECT team, SUM(matches_played) AS total_matches_played
    FROM (
        SELECT team_1 AS team, COUNT(*) AS matches_played
        FROM leetcode.icc_world_cup
        GROUP BY team_1
        UNION ALL
        SELECT team_2 AS team, COUNT(*) AS matches_played
        FROM leetcode.icc_world_cup
        GROUP BY team_2
    ) AS a
    GROUP BY team
),
winner1 AS (
    SELECT winner AS won_team, COUNT(*) AS number_of_wins
    FROM leetcode.icc_world_cup
    GROUP BY winner
)

SELECT c.team, c.total_matches_played, COALESCE(w.number_of_wins, 0) AS number_of_wins, total_matches_played - coalesce(w.number_of_wins,0) as losses, 2*coalesce(number_of_wins,0) as points
FROM cte c
LEFT JOIN winner1 w
ON c.team = w.won_team
order by number_of_wins desc;
