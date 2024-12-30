create table leetcode.players_location
(
name varchar(20),
city varchar(20)
);

insert into leetcode.players_location values 
('Sachin','Mumbai'),
('Virat','Delhi') ,
 ('Rahul','Bangalore'),
 ('Rohit','Mumbai'),
 ('Mayank','Bangalore');
 
 select *
 from leetcode.players_location;
 
 select city, count(name) as count_Players
 from leetcode.players_location
 group by city
 order by count(name) desc;

 WITH ranked_players AS (
    SELECT 
        ROW_NUMBER() OVER (PARTITION BY city ORDER BY name ASC) AS row_num,
        name,
        city
    FROM 
        leetcode.players_location
),

bangalore_cte AS (
    SELECT 
        row_num,
        name AS Bangalore
    FROM 
        ranked_players
    WHERE 
        city = 'Bangalore'
),

mumbai_cte AS (
    SELECT 
        row_num,
        name AS Mumbai
    FROM 
        ranked_players
    WHERE 
        city = 'Mumbai'
),

delhi_cte AS (
    SELECT 
        row_num,
        name AS Delhi
    FROM 
        ranked_players
    WHERE 
        city = 'Delhi'
),

all_rows AS (
    SELECT row_num FROM bangalore_cte
    UNION
    SELECT row_num FROM mumbai_cte
    UNION
    SELECT row_num FROM delhi_cte
)

-- Combine the results, ensuring all rows from all cities are included
SELECT
    b.Bangalore,
    m.Mumbai,
    d.Delhi
FROM
    all_rows ar
LEFT JOIN 
    bangalore_cte b ON ar.row_num = b.row_num
LEFT JOIN 
    mumbai_cte m ON ar.row_num = m.row_num
LEFT JOIN 
    delhi_cte d ON ar.row_num = d.row_num
ORDER BY 
    b.Bangalore, m.Mumbai, d.Delhi;
