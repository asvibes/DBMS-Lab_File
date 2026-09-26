CREATE DATABASE EmployeeProjectDB;
USE EmployeeProjectDB;

CREATE TABLE Department (
    DeptID INT PRIMARY KEY,
    DeptName VARCHAR(50) NOT NULL,
    Location VARCHAR(50)
);

desc table Department; 

CREATE TABLE Employee (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(100) NOT NULL,
    Gender VARCHAR(10),
    Salary DECIMAL(10,2),
    HireDate DATE,
    DeptID INT,
    ManagerID INT NULL,
    FOREIGN KEY (DeptID) REFERENCES Department(DeptID),
    FOREIGN KEY (ManagerID) REFERENCES Employee(EmpID)
);

desc table Employee;

CREATE TABLE Project (
    ProjectID INT PRIMARY KEY,
    ProjectName VARCHAR(100) NOT NULL,
    Budget DECIMAL(12,2),
    DeptID INT,
    FOREIGN KEY (DeptID) REFERENCES Department(DeptID)
);

desc table Project;

CREATE TABLE Employee_Project (
    EmpID INT,
    ProjectID INT,
    HoursWorked INT,
    Role VARCHAR(50),
    PRIMARY KEY (EmpID, ProjectID),
    FOREIGN KEY (EmpID) REFERENCES Employee(EmpID),
    FOREIGN KEY (ProjectID) REFERENCES Project(ProjectID)
);

desc table Employee_Project;


INSERT INTO Department VALUES
(1, 'IT', 'Lucknow'),
(2, 'HR', 'Delhi'),
(3, 'Finance', 'Mumbai'),
(4, 'Marketing', 'Bangalore'),
(5, 'Operations', 'Pune');


INSERT INTO Employee
(EmpID, EmpName, Gender, Salary, HireDate, DeptID, ManagerID)
VALUES
(1,  'Aarav Sharma',  'Male',   85000, '2021-01-15', 1, NULL),
(2,  'Priya Singh',   'Female', 75000, '2022-03-10', 1, 1),
(3,  'Rahul Verma',   'Male',   65000, '2023-06-12', 1, 1),
(4,  'Sneha Gupta',   'Female', 58000, '2023-08-20', 1, 2),
(5,  'Aditya Kumar',  'Male',   52000, '2024-01-05', 1, 2),
(6,  'Ananya Roy',    'Female', 49000, '2024-04-15', 1, 3),
(7,  'Riya Mehta',    'Female', 70000, '2021-02-18', 2, NULL),
(8,  'Karan Malhotra', 'Male',   60000, '2022-05-25', 2, 7),
(9,  'Pooja Yadav',   'Female', 54000, '2023-02-11', 2, 7),
(10, 'Vikas Jain',    'Male',   48000, '2024-06-19', 2, 8),
(11, 'Neha Kapoor',   'Female', 45000, '2024-09-01', 2, 8),
(12, 'Arjun Sinha',   'Male',   43000, '2025-01-10', 2, 9),
(13, 'Rohan Das',     'Male',   90000, '2020-11-15', 3, NULL),
(14, 'Kavya Sharma',  'Female', 78000, '2021-07-20', 3, 13),
(15, 'Manish Patel',  'Male',   68000, '2022-08-14', 3, 13),
(16, 'Isha Agarwal',  'Female', 62000, '2023-03-17', 3, 14),
(17, 'Nikhil Rao',    'Male',   55000, '2024-02-21', 3, 14),
(18, 'Meera Joshi',   'Female', 50000, '2024-07-10', 3, 15),
(19, 'Sahil Khan',    'Male',   72000, '2021-04-12', 4, NULL),
(20, 'Tanya Bose',    'Female', 64000, '2022-06-22', 4, 19),
(21, 'Yash Thakur',   'Male',   57000, '2023-01-13', 4, 19),
(22, 'Simran Kaur',   'Female', 53000, '2023-10-05', 4, 20),
(23, 'Mohit Bansal',  'Male',   47000, '2024-05-18', 4, 20),
(24, 'Aditi Mishra',  'Female', 44000, '2025-02-15', 4, 21),
(25, 'Varun Gupta',   'Male',   68000, '2021-09-10', 5, NULL),
(26, 'Naina Sharma',  'Female', 59000, '2022-11-12', 5, 25),
(27, 'Deepak Singh',  'Male',   54000, '2023-04-20', 5, 25),
(28, 'Muskan Verma',  'Female', 50000, '2024-03-14', 5, 26),
(29, 'Rajat Kumar',   'Male',   46000, '2024-08-16', 5, 26),
(30, 'Pallavi Roy',   'Female', 42000, '2025-03-01', 5, 27);

INSERT INTO Project VALUES
(101, 'Cloud Migration',       500000, 1),
(102, 'AI Development',        750000, 1),
(103, 'Employee Portal',       300000, 2),
(104, 'Financial Analysis',    600000, 3),
(105, 'Budget Management',     450000, 3),
(106, 'Digital Marketing',     350000, 4),
(107, 'Market Research',       250000, 4),
(108, 'Supply Chain System',   550000, 5);

INSERT INTO Employee_Project VALUES
(1,101,120,'Project Manager'),
(2,101,100,'Developer'),
(3,101,90,'Developer'),
(4,102,110,'ML Engineer'),
(5,102,100,'Developer'),
(6,102,80,'Tester'),
(7,103,120,'Project Manager'),
(8,103,100,'HR Specialist'),
(9,103,90,'HR Executive'),
(10,103,80,'Developer'),
(13,104,130,'Project Manager'),
(14,104,110,'Financial Analyst'),
(15,104,100,'Analyst'),
(16,104,90,'Accountant')
(13,105,100,'Project Manager'),
(17,105,90,'Analyst'),
(18,105,80,'Accountant'),
(19,106,120,'Project Manager'),
(20,106,100,'Marketing Executive'),
(21,106,90,'Designer'),
(22,106,80,'Marketing Executive'),
(19,107,100,'Project Manager'),
(23,107,80,'Researcher'),
(24,107,70,'Researcher'),
(25,108,120,'Project Manager'),
(26,108,100,'Operations Executive'),
(27,108,90,'Analyst'),
(28,108,80,'Operations Executive'),
(29,101,60,'Support'),
(30,103,50,'Support');

SELECT *
FROM Employee;


SELECT *
FROM Department;

SELECT *
FROM employee_project;

SELECT *
FROM project;

-- SELECTION

SELECT *
FROM Employee
WHERE Salary > 60000;

-- PROJECTION

SELECT EmpName, Salary
FROM Employee;


-- SELECTION + PROJECTION


SELECT EmpName, Salary
FROM Employee
WHERE Salary > 60000;


-- AGGREGATE FUNCTIONS

SELECT COUNT(*) AS TotalEmployees
FROM Employee;

SELECT AVG(Salary) AS AverageSalary
FROM Employee; 

SELECT MAX(Salary) AS MaximumSalary
FROM Employee; 

SELECT MIN(Salary) AS MinimumSalary
FROM Employee;


SELECT SUM(Salary) AS TotalSalary
FROM Employee; 


-- GROUP BY

SELECT DeptID, AVG(Salary) AS AverageSalary
FROM Employee
GROUP BY DeptID;

-- GROUP BY WITH DEPARTMENT NAME

SELECT
    d.DeptName,
    COUNT(e.EmpID) AS EmployeeCount,
    AVG(e.Salary) AS AverageSalary
FROM Department d
JOIN Employee e
ON d.DeptID = e.DeptID
GROUP BY d.DeptName;

-- HAVING

SELECT
    DeptID,
    AVG(Salary) AS AverageSalary
FROM Employee
GROUP BY DeptID
HAVING AVG(Salary) > 60000; 

-- CASE EXPRESSION

SELECT
    EmpName,
    Salary,
    CASE
        WHEN Salary >= 70000 THEN 'High Salary'
        WHEN Salary >= 50000 THEN 'Medium Salary'
        ELSE 'Low Salary'
    END AS SalaryCategory
FROM Employee;

-- CASE WITH DEPARTMENT

SELECT
    EmpName,
    DeptID,
    Salary,
    CASE
        WHEN Salary >= 70000 THEN 'Senior'
        WHEN Salary >= 50000 THEN 'Mid-Level'
        ELSE 'Junior'
    END AS EmployeeLevel
FROM Employee;

-- ORDER BY

SELECT EmpName, Salary
FROM Employee
ORDER BY Salary DESC;

