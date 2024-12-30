/*user purchase platform
-- The table logs the spending history of users that make purchases from an online shopping website which has a desktop and a mobile application 
write a SQL query to find the total number of users and the total amount spent using mobile only,desktop only, and both mobile and desktop together for each date*/
create table leetcode.spending 
(
user_id int,
spend_date date,
platform varchar(10),
amount int
);

insert into leetcode.spending values
(1,'2019-07-01','mobile',100),
(1,'2019-07-01','desktop',100),
(2,'2019-07-01','mobile',100),
(2,'2019-07-02','mobile',100),
(3,'2019-07-01','desktop',100),
(3,'2019-07-02','desktop',100);

select *
from leetcode.spending;

select spend_date, platform, 