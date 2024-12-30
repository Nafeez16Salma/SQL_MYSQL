/*pwc sql question
common in both tables should not be there
need the output as uncommon, mismatched  values in both the tables*/

create table leetcode.source
(
id int,
name varchar(5)
 );

create table leetcode.target
(id int, 
name varchar(5)
);

insert into leetcode.source values
(1,'A'),
(2,'B'),
(3,'C'),
(4,'D');

insert into leetcode.target values
(1,'A'),
(2,'B'),
(4,'X'),
(5,'F');

-- Simulate FULL OUTER JOIN in MySQL

-- Left Outer Join
WITH cte AS (
    -- Left Outer Join to get all records from source and matching records from target
    SELECT 
        s.id AS id, 
        s.name AS name, 
        t.id AS t_id, 
        t.name AS t_name
    FROM 
        leetcode.source s
    LEFT JOIN 
        leetcode.target t
    ON 
        s.id = t.id

    UNION

    -- Right Outer Join to get all records from target and matching records from source
    SELECT 
        s.id AS id, 
        s.name AS name, 
        t.id AS t_id, 
        t.name AS t_name
    FROM 
        leetcode.source s
    RIGHT JOIN 
        leetcode.target t
    ON 
        s.id = t.id
)

SELECT 
   coalesce( id,
    t_id) as id,
    CASE 
        WHEN t_id IS NULL OR ID IS NULL THEN 'Content not there'
        WHEN name = t_name THEN 'Content present'
        ELSE 'Content mismatch'
    END AS status
FROM 
    cte
where name != t_name or t_name is null or name is null;

