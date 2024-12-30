/* write a SQL to return all employees whose salary is same in same department*/
CREATE TABLE leetcode.emp_salaries
(
    emp_id INTEGER NOT NULL,
    name VARCHAR(20) NOT NULL,
    salary VARCHAR(30),  
    dept_id INTEGER
);

INSERT INTO leetcode.emp_salaries VALUES
(101, 'sohan', '3000', '11'),
(102, 'rohan', '4000', '12'),
(103, 'mohan', '5000', '13'),
(104, 'cat', '3000', '11'),
(105, 'suresh', '4000', '12'),
(109, 'mahesh', '7000', '12'),
(108, 'kamal', '8000', '11');

SELECT emp_id, name, salary, dept_id
from leetcode.emp_salaries
where salary in
(select salary
from leetcode.emp_salaries
group by salary
having count(salary)>1
);



