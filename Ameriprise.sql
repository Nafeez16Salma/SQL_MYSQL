create table leetcode.Ameriprise_LLC
(
teamID varchar(2),
memberID varchar(10),
Criteria1 varchar(1),
Criteria2 varchar(1)
);
insert into leetcode.Ameriprise_LLC values 
('T1','T1_mbr1','Y','Y'),
('T1','T1_mbr2','Y','Y'),
('T1','T1_mbr3','Y','Y'),
('T1','T1_mbr4','Y','Y'),
('T1','T1_mbr5','Y','N'),
('T2','T2_mbr1','Y','Y'),
('T2','T2_mbr2','Y','N'),
('T2','T2_mbr3','N','Y'),
('T2','T2_mbr4','N','N'),
('T2','T2_mbr5','N','N'),
('T3','T3_mbr1','Y','Y'),
('T3','T3_mbr2','Y','Y'),
('T3','T3_mbr3','N','Y'),
('T3','T3_mbr4','N','Y'),
('T3','T3_mbr5','Y','N');

select *
from leetcode.Ameriprise_LLC;

WITH cte AS (
    SELECT 
        teamID,
        memberID,
        Criteria1,
        Criteria2,
        CASE
            WHEN Criteria1 = 'Y' AND Criteria2 = 'N' THEN 'N'
            WHEN Criteria1 = 'Y' AND Criteria2 = 'Y' THEN 'Y'
            WHEN Criteria1 = 'N' AND Criteria2 = 'Y' THEN 'N'
            WHEN Criteria1 = 'N' AND Criteria2 = 'N' THEN 'N'
            ELSE NULL
        END AS OUTPUT
    FROM leetcode.Ameriprise_LLC
),
aggregate_cte AS (
    SELECT 
        teamID,
        COUNT(*) AS total_count,
        SUM(CASE WHEN OUTPUT = 'Y' THEN 1 ELSE 0 END) AS count_if_yes
    FROM cte
    GROUP BY teamID
)

SELECT 
    c.teamID,
    c.Criteria1,
    c.Criteria2,
    c.OUTPUT,
    a.total_count,
    a.count_if_yes
FROM cte c
JOIN aggregate_cte a ON c.teamID = a.teamID;



