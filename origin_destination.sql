CREATE TABLE leetcode.flights 
(
    cid VARCHAR(512),
    fid VARCHAR(512),
    origin VARCHAR(512),
    Destination VARCHAR(512)
);

INSERT INTO leetcode.flights VALUES 
 ('1', 'f1', 'Del', 'Hyd'),
 ('1', 'f2', 'Hyd', 'Blr'),
('2', 'f3', 'Mum', 'Agra'),
('2', 'f4', 'Agra', 'Kol');

select f1.cid,f1.origin, f2.destination
from
leetcode.flights f1
inner join leetcode.flights f2
on f1.cid = f2.cid and f1.destination = f2.origin;




