/* find the room types that are searched most number of times.
output the roomtype alongside the number of searches for it
If the filter for room types has more than one room type, consider each unique room type as a separate row,
sort the results based on number of searches in descending order*/

create table leetcode.airbnb_searches 
(
user_id int,
date_searched date,
filter_room_types varchar(200)
);



insert into leetcode.airbnb_searches values
(1,'2022-01-01','entire home,private room'),
(2,'2022-01-02','entire home,shared room'),
(3,'2022-01-02','private room,shared room'),
(4,'2022-01-03','private room');

-- Splitting the string using a recursive CTE
WITH RECURSIVE split_cte AS (
    SELECT
        user_id,
        date_searched,
        SUBSTRING_INDEX(filter_room_types, ',', 1) AS room_type,
        SUBSTRING(filter_room_types, LENGTH(SUBSTRING_INDEX(filter_room_types, ',', 1)) + 2) AS rest
    FROM leetcode.airbnb_searches
    UNION ALL
    SELECT
        user_id,
        date_searched,
        SUBSTRING_INDEX(rest, ',', 1) AS room_type,
        SUBSTRING(rest, LENGTH(SUBSTRING_INDEX(rest, ',', 1)) + 2) AS rest
    FROM split_cte
    WHERE rest <> ''
)
SELECT room_type, COUNT(room_type) AS counts
FROM split_cte
GROUP BY room_type
ORDER BY counts DESC;






