/* Write a query to find busiest route along with total ticket count
oneway_round = 'O' -> One way Trip
oneway_round = 'R' -> Round Trip
Note: DEL -> BOM is different from BOM -> DEL*/

CREATE TABLE leetcode.ticet (
    airline_number VARCHAR(10),
    origin VARCHAR(3),
    destination VARCHAR(3),
    oneway_round CHAR(1),
    ticket_count INT
);

INSERT INTO leetcode.ticet VALUES
    ('DEF456', 'BOM', 'DEL', 'O', 150),
    ('GHI789', 'DEL', 'BOM', 'R', 50),
    ('JKL012', 'BOM', 'DEL', 'R', 75),
    ('MNO345', 'DEL', 'NYC', 'O', 200),
    ('PQR678', 'NYC', 'DEL', 'O', 180),
    ('STU901', 'NYC', 'DEL', 'R', 60),
    ('ABC123', 'DEL', 'BOM', 'O', 100),
    ('VWX234', 'DEL', 'NYC', 'R', 90);
    
select *
from leetcode.ticet;
/*my code*/
WITH cte AS (
    SELECT 
        *, 
        CONCAT(origin, '-', destination) AS concated_column
    FROM leetcode.ticet
)
SELECT concated_column, sum(ticket_count) as sum_ticket_count
FROM cte
group by concated_column
order by sum_ticket_count desc;

/*According to the given code*/
WITH cte1 AS (
    SELECT 1, oneway_round, ticket_count,
        CONCAT(origin, '-', destination) AS concated_column
	FROM leetcode.ticet
	UNION ALL
    SELECT 2,oneway_round , ticket_count,concat(destination,'-',origin) AS concated_column
    FROM leetcode.ticet
	where oneway_round = 'R'
)
SELECT concated_column, sum(ticket_count) as sum_ticket_count
FROM cte1
group by concated_column
order by sum_ticket_count desc;


