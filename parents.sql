create table leetcode.people
(id int primary key not null,
 name varchar(20),
 gender char(2));

create table leetcode.relations
(
    c_id int,
    p_id int,
    FOREIGN KEY (c_id) REFERENCES people(id),
    foreign key (p_id) references people(id)
);

insert into leetcode.people values
    (107,'Days','F'),
    (145,'Hawbaker','M'),
    (155,'Hansel','F'),
    (202,'Blackston','M'),
    (227,'Criss','F'),
    (278,'Keffer','M'),
    (305,'Canty','M'),
    (329,'Mozingo','M'),
    (425,'Nolf','M'),
    (534,'Waugh','M'),
    (586,'Tong','M'),
    (618,'Dimartino','M'),
    (747,'Beane','M'),
    (878,'Chatmon','F'),
    (904,'Hansard','F');

insert into leetcode.relations values
    (145, 202),
    (145, 107),
    (278,305),
    (278,155),
    (329, 425),
    (329,227),
    (534,586),
    (534,878),
    (618,747),
    (618,904);
select *
from leetcode.people;

select *
from leetcode.relations;

SELECT
    c.name AS children_name,
    MAX(CASE WHEN p.gender = 'M' THEN p.name ELSE NULL END) AS father,
    MAX(CASE WHEN p.gender = 'F' THEN p.name ELSE NULL END) AS mother
FROM
    leetcode.people p
INNER JOIN
    leetcode.relations r ON p.id = r.p_id
INNER JOIN
    leetcode.people c ON r.c_id = c.id
GROUP BY
    c.name; 


