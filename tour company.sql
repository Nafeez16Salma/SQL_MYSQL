/* A travel and tour company has 2 tables that relate to customers: FAMILIES AND COUNTRIES. Each tour offers a discount if a minimum number of people book at same time.
Write a query to print the maximum number of discounted tours any 1 family in the families table can choose from*/

CREATE TABLE leetcode.FAMILIES (
    ID VARCHAR(50),
    NAME VARCHAR(50),
    FAMILY_SIZE INT
);

-- Insert data into FAMILIES table
INSERT INTO leetcode.FAMILIES VALUES 
    ('c00dac11bde74750b4d207b9c182a85f', 'Alex Thomas', 9),
    ('eb6f2d3426694667ae3e79d6274114a4', 'Chris Gray', 2),
    ('3f7b5b8e835d4e1c8b3e12e964a741f3', 'Emily Johnson', 4),
    ('9a345b079d9f4d3cafb2d4c11d20f8ce', 'Michael Brown', 6),
    ('e0a5f57516024de2a231d09de2cbe9d1', 'Jessica Wilson', 3);

-- Create COUNTRIES table
CREATE TABLE leetcode.COUNTRIES (
    ID VARCHAR(50),
    NAME VARCHAR(50),
    MIN_SIZE INT,
 MAX_SIZE INT
);

INSERT INTO leetcode.COUNTRIES VALUES 
    ('023fd23615bd4ff4b2ae0a13ed7efec9', 'Bolivia', 2 , 4),
    ('be247f73de0f4b2d810367cb26941fb9', 'Cook Islands', 4,8),
    ('3e85ab80a6f84ef3b9068b21dbcc54b3', 'Brazil', 4,7),
    ('e571e164152c4f7c8413e2734f67b146', 'Australia', 5,9),
    ('f35a7bb7d44342f7a8a42a53115294a8', 'Canada', 3,5),
    ('a1b5a4b5fc5f46f891d9040566a78f27', 'Japan', 10,12);
    
    
select *
from leetcode.families;

select *
from leetcode.countries;

WITH cte AS (
    SELECT 
        l.name AS family_name, 
        l.family_size, 
        c.name AS country_name, 
        c.min_size, 
        c.max_size
    FROM leetcode.families l
    CROSS JOIN leetcode.countries c
)

SELECT 
    discount_given,family_name,
    COUNT(*) AS count_discount
FROM (
    SELECT 
        *,
        CASE
            WHEN family_size >= min_size AND family_size <= max_size THEN 'discount'
            ELSE 'no discount'
        END AS discount_given
    FROM cte
) AS subquery
where discount_given = 'discount'
GROUP BY discount_given, family_name
order by count_discount desc;
