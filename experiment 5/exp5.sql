-- USING EXPERIMENT – 3 DATABASE

-- DEPARTMENT SALARY SUMMARY VIEW:

CREATE TABLE IF NOT EXISTS Department_Salary_Summary AS

SELECT 

    d.dept_id,

    d.dept_name,

    COUNT(e.emp_id) AS total_employees,

    SUM(e.salary) AS total_salary,

    AVG(e.salary) AS average_salary,

    MAX(e.salary) AS highest_salary,

    MIN(e.salary) AS lowest_salary

FROM Department d

LEFT JOIN Employee e ON d.dept_id = e.dept_id

GROUP BY d.dept_id, d.dept_name;

SELECT \* FROM Department_Salary_Summary;


**QUERY THE VIEW:**

SELECT 

dept_name, 

average_salary 

FROM Department_Salary_Summary 

WHERE average_salary > 85000;



ALTER TABLE Employee 

ADD manager_id INT NULL; 

ALTER TABLE Employee 

ADD CONSTRAINT fk_employee_manager 

FOREIGN KEY (manager_id) 

REFERENCES Employee(emp_id); 



\-- Update Manager IDs 

UPDATE Employee SET manager_id = NULL WHERE emp_id IN 

(105, 112, 114, 122, 125); -- IT 

UPDATE Employee 

SET manager_id = 105 

WHERE emp_id IN (103, 104); 

UPDATE Employee 

SET manager_id = 103 

WHERE emp_id IN (101, 102); 

UPDATE Employee 

SET manager_id = 104 

WHERE emp_id = 106; -- HR 

UPDATE Employee 

SET manager_id = 105 

WHERE emp_id IN (103, 104); 

UPDATE Employee 

SET manager_id = 103 

WHERE emp_id IN (101, 102); 

UPDATE Employee 

SET manager_id = 104 

WHERE emp_id = 106; -- Finance 

UPDATE Employee 

SET manager_id = 112 

WHERE emp_id IN (107, 108); 

UPDATE Employee 

SET manager_id = 107 

WHERE emp_id = 109; 

UPDATE Employee 

SET manager_id = 108 

WHERE emp_id IN (110, 111); -- Marketing 

UPDATE Employee 

SET manager_id = 112 

WHERE emp_id IN (107, 108); 

UPDATE Employee 

SET manager_id = 107 

WHERE emp_id = 109; 

UPDATE Employee 

SET manager_id = 108 

WHERE emp_id IN (110, 111); -- Research 

UPDATE Employee 

SET manager_id = 125 

WHERE emp_id IN (126, 127, 128); 

UPDATE Employee 

SET manager_id = 126 

WHERE emp_id = 129; 

UPDATE Employee 

SET manager_id = 128 

WHERE emp_id = 130;



CREATE VIEW Employee_Hierarchy AS 

SELECT 

e.emp_id, 

e.emp_name AS employee_name, 

e.manager_id, 

m.emp_name AS manager_name, 

e.salary, 

e.dept_id 

FROM Employee e 

LEFT JOIN Employee m 

ON e.manager_id = m.emp_id; 

SELECT \* 

FROM Employee_Hierarchy; 



CREATE VIEW Employee_Basic AS 

SELECT 

    emp_id, 

    emp_name, 

    salary, 

    dept_id 

FROM Employee; 

SELECT \* 

FROM Employee_Basic 

WHERE emp_id = 103; 



UPDATE Employee_Basic 

SET salary = 78000 

WHERE emp_id = 101; 

SELECT \* 

FROM Employee 

WHERE emp_id = 101;

UPDATE Department_Salary_Summary 

SET average_salary = 90000 

WHERE dept_id = 1;



UPDATE Department_Salary_Summary 

SET average_salary = 90000 

WHERE dept_id = 1;



WITH RECURSIVE EmployeeChain AS 

( 

    -- Anchor member 

    SELECT 

        emp_id, 

        emp_name, 

        manager_id, 

        0 AS level, 

        CAST(emp_name AS CHAR(500)) AS reporting_chain 

    FROM Employee 

    WHERE manager_id IS NULL 

    UNION ALL 

    -- Recursive member 

    SELECT 

        e.emp_id, 

        e.emp_name, 

        e.manager_id, 

        ec.level + 1, 

        CONCAT(ec.reporting_chain, ' -> ', e.emp_name) 

    FROM Employee e 

    INNER JOIN EmployeeChain ec 

        ON e.manager_id = ec.emp_id 

) 

SELECT 

    emp_id, 

    emp_name, 

    manager_id, 

    level, 

    reporting_chain 

FROM EmployeeChain 

ORDER BY reporting_chain; 




WITH RECURSIVE ReportingChain AS 

( 

    SELECT 

        emp_id, 

        emp_name, 

        manager_id, 

        0 AS level 

    FROM Employee 

    WHERE emp_id = 101 

    UNION ALL 

    SELECT 

        e.emp_id, 

        e.emp_name, 

        e.manager_id, 

        rc.level + 1 

    FROM Employee e 

    JOIN ReportingChain rc 

        ON e.emp_id = rc.manager_id 

) 

SELECT 

    emp_id, 

    emp_name, 

manager_id, 

level 

FROM ReportingChain; 

