/* find the words which are printing more than once considering all the rows of the content columns*/
create table leetcode.namaste_python (
file_name varchar(25),
content varchar(200)
);

insert into leetcode.namaste_python values
('python bootcamp1.txt','python for data analytics 0 to hero bootcamp starting on Jan 6th'),
('python bootcamp2.txt','classes will be held on weekends from 11am to 1 pm for 5-6 weeks'),
('python bootcamp3.txt','use code NY2024 to get 33 percent off. You can register from namaste sql website. Link in pinned comment');

select *
from leetcode.namaste_python;

-- Create a temporary table with numbers
CREATE TEMPORARY TABLE leetcode.Numbers (n INT);
INSERT INTO leetcode.Numbers (n) VALUES 
    (1), (2), (3), (4), (5), (6), (7), (8), (9), (10),
    (11), (12), (13), (14), (15), (16), (17), (18), (19), (20);
-- Extend as needed for the maximum number of words in your sentences

-- Split each sentence into words
select word,count(word)
from(
SELECT 
    content,
    SUBSTRING_INDEX(SUBSTRING_INDEX(content, ' ', Numbers.n), ' ', -1) AS word
FROM leetcode.namaste_python
JOIN leetcode.Numbers ON CHAR_LENGTH(content) - CHAR_LENGTH(REPLACE(content, ' ', '')) >= Numbers.n - 1
ORDER BY content, Numbers.n) as counted_words
group by word
having count(word)>1
order by count(word) desc;
/* In SQL Server for splitting a string we will use cross apply string_split('column_name', delimiter*/

