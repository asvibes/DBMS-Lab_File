USE EmployeeProjectDB;

-- 1. INNER JOIN
SELECT
    e.EmpID,
    e.EmpName,
    d.DeptName
FROM Employee e
INNER JOIN Department d
ON e.DeptID = d.DeptID;


-- 2. LEFT JOIN


SELECT
    d.DeptID,
    d.DeptName,
    e.EmpName
FROM Department d
LEFT JOIN Employee e
ON d.DeptID = e.DeptID;



-- 3. SELF JOIN


SELECT
    e.EmpName AS Employee,
    m.EmpName AS Manager
FROM Employee e
LEFT JOIN Employee m
ON e.ManagerID = m.EmpID;



-- 4. 3-WAY JOIN


SELECT
    e.EmpName,
    d.DeptName,
    p.ProjectName
FROM Employee e
INNER JOIN Department d
ON e.DeptID = d.DeptID
INNER JOIN Employee_Project ep
ON e.EmpID = ep.EmpID
INNER JOIN Project p
ON ep.ProjectID = p.ProjectID;


-- 5. CORRELATED SUBQUERY


SELECT
    e.EmpName,
    e.Salary,
    e.DeptID
FROM Employee e
WHERE e.Salary >
(
    SELECT AVG(e2.Salary)
    FROM Employee e2
    WHERE e2.DeptID = e.DeptID
);


-- 6. EXISTS


SELECT
    e.EmpID,
    e.EmpName
FROM Employee e
WHERE EXISTS
(
    SELECT 1
    FROM Employee_Project ep
    WHERE ep.EmpID = e.EmpID
);


-- 7. SIMULATED INTERSECT


SELECT
    e.EmpID,
    e.EmpName
FROM Employee e
WHERE e.DeptID = 1
AND EXISTS
(
    SELECT 1
    FROM Employee_Project ep
    WHERE ep.EmpID = e.EmpID
    AND ep.ProjectID = 101
);



-- 8. SIMULATED EXCEPT


SELECT
    e.EmpID,
    e.EmpName
FROM Employee e
WHERE e.DeptID = 1
AND NOT EXISTS
(
    SELECT 1
    FROM Employee_Project ep
    WHERE ep.EmpID = e.EmpID
    AND ep.ProjectID = 101
);



-- 9. EXPLAIN - INNER JOIN


EXPLAIN
SELECT
    e.EmpName,
    d.DeptName
FROM Employee e
INNER JOIN Department d
ON e.DeptID = d.DeptID;



-- 10. EXPLAIN - LEFT JOIN


EXPLAIN
SELECT
    d.DeptName,
    e.EmpName
FROM Department d
LEFT JOIN Employee e
ON d.DeptID = e.DeptID;



-- 11. EXPLAIN - CORRELATED SUBQUERY

EXPLAIN
SELECT
    e.EmpName,
    e.Salary
FROM Employee e
WHERE e.Salary >
(
    SELECT AVG(e2.Salary)
    FROM Employee e2
    WHERE e2.DeptID = e.DeptID
);


-- 12. EXPLAIN - EXISTS


EXPLAIN
SELECT
    e.EmpName
FROM Employee e
WHERE EXISTS
(
    SELECT 1
    FROM Employee_Project ep
    WHERE ep.EmpID = e.EmpID
);



CREATE INDEX idx_employee_dept
ON Employee(DeptID);

CREATE INDEX idx_employee_manager
ON Employee(ManagerID);

CREATE INDEX idx_employee_project_emp
ON Employee_Project(EmpID);



EXPLAIN
SELECT
    e.EmpName,
    d.DeptName
FROM Employee e
INNER JOIN Department d
ON e.DeptID = d.DeptID;