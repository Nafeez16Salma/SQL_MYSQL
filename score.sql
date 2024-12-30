/* write a SQL query to report the students (student_id, student name) "being quiet" in exams.
A quiet student is the one who took atleast one exam and didn't score neither the high score nor the low score in any of the exam.
Don't return the student who has never taken any exam. Return the result table ordered by student_id*/

create table leetcode.students
(
student_id int,
student_name varchar(20)
);
insert into leetcode.students values
(1,'Daniel'),
(2,'Jade'),
(3,'Stella'),
(4,'Jonathan'),
(5,'Will');

create table leetcode.examss
(
exam_id int,
student_id int,
score int);

insert into leetcode.examss values
(10,1,70),
(10,2,80),
(10,3,90),
(20,1,80),
(30,1,70),
(30,3,80),
(30,4,90),
(40,1,60),
(40,2,70),
(40,4,80);

select *
from leetcode.students;

select *
from leetcode.examss;

with cte as(
select exam_id,e.student_id,score,s.student_name from leetcode.examss e
inner join leetcode.students s
on e.student_id = s.student_id)
,cte1 as(
select exam_id, min(score) as min_score,max(score) as max_Score
from cte
group by exam_id)

select distinct student_id , student_name
from(
select cte.exam_id,student_id,score,student_name,min_score,max_score
from cte
inner join cte1
on cte.exam_id = cte1.exam_id 
where score > min_score and score < max_score) as sub_query;


