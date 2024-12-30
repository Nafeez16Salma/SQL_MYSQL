/* write an SQL query to find the winner in each group
the winner in each group is the player who scored the maximum total points within the group. in case of tie, lowest player id wins*/
create table leetcode.players
(player_id int,
group_id int);

insert into leetcode.players values 
(15,1),
(25,1),
(30,1),
(45,1),
(10,2),
(35,2),
(50,2),
(20,3),
(40,3);

create table leetcode.matches
(
match_id int,
first_player int,
second_player int,
first_score int,
second_score int);

insert into leetcode.matches values 
(1,15,45,3,0),
(2,30,25,1,2),
(3,30,15,2,0),
(4,40,20,5,2),
(5,35,50,1,1);

select *
from leetcode.players;

select *
from leetcode.matches;

with cte as(
select player,sum(score) as total_score
from(
select first_player as player, first_score as score
from leetcode.matches
union all
select second_player,second_score
from leetcode.matches) a
 group by player)
 
 , r as(select c.player,c.total_score, p. group_id, 
 rank() over (partition by p.group_id order by c.total_score desc,c.player asc) as rn
 from cte c 
 inner join leetcode.players p
 on c.player = p.player_id
)
SELECT 
    player,
    total_score,
    group_id
FROM 
    r
WHERE 
    rn = 1
ORDER BY 
    group_id;