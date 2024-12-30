/* Market Analysis: Write an SQL Query to find for each seller, wether the brand of the second item ( by date) they sold is their favorite
If a seller sold less than two items, report the answer for that seller as no. o/p
seller id 2_nd_item_fav brand
1
 yes/no
 2 yes/no
 */
 
create table leetcode.userss (
user_id int,
join_date date,
favorite_brand  varchar(50));

 create table leetcode.orders (
 order_id int,
 order_date date,
 item_id int,
 buyer_id int,
 seller_id int 
 );

 create table leetcode.items
 (
 item_id int,
 item_brand varchar(50)
 );


 insert into leetcode.userss values 
 (1,'2019-01-01','Lenovo'),
 (2,'2019-02-09','Samsung'),
 (3,'2019-01-19','LG'),
 (4,'2019-05-21','HP');

 insert into leetcode.items values 
 (1,'Samsung'),
 (2,'Lenovo'),
 (3,'LG'),
 (4,'HP');

 insert into leetcode.orders values 
 (1,'2019-08-01',4,1,2),
 (2,'2019-08-02',2,1,3),
 (3,'2019-08-03',3,2,3),
 (4,'2019-08-04',1,4,2),
 (5,'2019-08-04',1,3,4),
 (6,'2019-08-05',2,2,4);
 
 select *
 from leetcode.userss;
 

 
 with c as(
 select *
 from(
 select *, rank() over (partition by seller_id order by order_date) as rn
 from leetcode.orders) a
 where rn = 2
 )
 ,c1 as(
 select c.order_id,c.order_date,c.item_id,c.seller_id,rn,i.item_brand
 from c
 inner join leetcode.items i
 on c.item_id = i.item_id
 )
 , c2 as(
 select c1.item_id,c1.seller_id,c1.item_brand,u.favorite_brand
 from c1
 inner join leetcode.userss u
 on c1.seller_id = u.user_id)
select *
from(
 select seller_id,
 case when item_brand = favorite_brand then 'YES'
 else null end as selected_brand
 from c2) A
 where selected_brand = 'YES'