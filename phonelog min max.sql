/* there is a phonelog table that has information  about callers call history
write a SQL to find out callers whose first and last call was to the same person on a given day*/
create table leetcode.phonelog(
    Callerid int, 
    Recipientid int,
    Datecalled datetime
);

insert into leetcode.phonelog values
	   (1, 2, '2019-01-01 09:00:00.000'),
       (1, 3, '2019-01-01 17:00:00.000'),
       (1, 4, '2019-01-01 23:00:00.000'),
       (2, 5, '2019-07-05 09:00:00.000'),
       (2, 3, '2019-07-05 17:00:00.000'),
       (2, 3, '2019-07-05 17:20:00.000'),
       (2, 5, '2019-07-05 23:00:00.000'),
       (2, 3, '2019-08-01 09:00:00.000'),
       (2, 3, '2019-08-01 17:00:00.000'),
       (2, 5, '2019-08-01 19:30:00.000'),
       (2, 4, '2019-08-02 09:00:00.000'),
       (2, 5, '2019-08-02 10:00:00.000'),
       (2, 5, '2019-08-02 10:45:00.000'),
       (2, 4, '2019-08-02 11:00:00.000');     
with c as (
select callerid, date(Datecalled) as datee,min(datecalled) as min_time,max(datecalled) as max_time
from leetcode.phonelog 
group by callerid,date(Datecalled))

select c.callerid , p1.recipientid as min_r from c
inner join leetcode.phonelog p1 on c.callerid = p1.callerid and c.min_time = p1.Datecalled
inner join leetcode.phonelog p2 on c.callerid = p2.callerid and c.max_time = p2.datecalled
where p1.recipientid = p2.recipientid

