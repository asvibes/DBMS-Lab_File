CREATE DATABASE SalesNormalization;
USE SalesNormalization;
CREATE TABLE Sales_UNF (
 Order_ID INT,
 Order_Date DATE,
 Customer_ID VARCHAR(10),
 Customer_Name VARCHAR(50),
 Product_ID VARCHAR(10),
 Product_Name VARCHAR(50),
 Quantity INT,
 Unit_Price DECIMAL(10,2),
 Salesperson_ID VARCHAR(10),
 Salesperson_Name VARCHAR(50)
);

INSERT INTO Sales_UNF VALUES
(1001, '2026-01-10', 'C01', 'Aarav', 'P01', 'Laptop', 2,
50000, 'S01', 'Rahul'),
(1001, '2026-01-10', 'C01', 'Aarav', 'P02', 'Mouse', 3, 500,
'S01', 'Rahul'),
(1002, '2026-01-12', 'C02', 'Priya', 'P01', 'Laptop', 1,
50000, 'S02', 'Neha'),
(1003, '2026-01-15', 'C03', 'Rohan', 'P03', 'Keyboard', 2,
1500, 'S01', 'Rahul'),
(1004, '2026-01-18', 'C01', 'Aarav', 'P03', 'Keyboard', 1,
1500, 'S02', 'Neha'),
(1005, '2026-01-20', 'C04', 'Meera', 'P02', 'Mouse', 4, 500,
'S03', 'Amit');


SELECT * FROM Sales_UNF;

CREATE TABLE Sales_1NF (
 Order_ID INT,
 Order_Date DATE,
 Customer_ID VARCHAR(10),
 Customer_Name VARCHAR(50),
 Product_ID VARCHAR(10),
 Product_Name VARCHAR(50),
 Quantity INT,
 Unit_Price DECIMAL(10,2),
 Salesperson_ID VARCHAR(10),
 Salesperson_Name VARCHAR(50),
 PRIMARY KEY (Order_ID, Product_ID)
);

SELECT * FROM Sales_UNF;

INSERT INTO Sales_1NF 
SELECT * FROM Sales_UNF;

SELECT * FROM Sales_1NF;

CREATE TABLE Orders (
 Order_ID INT PRIMARY KEY,
 Order_Date DATE,
 Customer_ID VARCHAR(10),
 Customer_Name VARCHAR(50),
 Salesperson_ID VARCHAR(10),
 Salesperson_Name VARCHAR(50)
);

INSERT INTO Orders
SELECT DISTINCT
    Order_ID,
    Order_Date,
    Customer_ID,
    Customer_Name,
    Salesperson_ID,
    Salesperson_Name
FROM Sales_1NF;

CREATE TABLE Products (
 Product_ID VARCHAR(10) PRIMARY KEY,
 Product_Name VARCHAR(50),
 Unit_Price DECIMAL(10,2)
);

INSERT INTO Products
SELECT DISTINCT
 Product_ID,
 Product_Name,
 Unit_Price
FROM Sales_1NF;


CREATE TABLE Order_Details (
 Order_ID INT,
 Product_ID VARCHAR(10),
 Quantity INT,
 PRIMARY KEY (Order_ID, Product_ID),
 FOREIGN KEY (Order_ID) REFERENCES Orders(Order_ID),
 FOREIGN KEY (Product_ID) REFERENCES Products(Product_ID)
);

INSERT INTO Order_Details
SELECT Order_ID, Product_ID, Quantity
FROM Sales_1NF;

SELECT * FROM Orders;

SELECT * FROM Products;

SELECT * FROM Order_Details;

CREATE TABLE Customers (
 Customer_ID VARCHAR(10) PRIMARY KEY,
 Customer_Name VARCHAR(50)
);

INSERT INTO Customers
SELECT DISTINCT Customer_ID, Customer_Name
FROM Sales_1NF;

CREATE TABLE Salespersons (
 Salesperson_ID VARCHAR(10) PRIMARY KEY,
 Salesperson_Name VARCHAR(50)
);

INSERT INTO Salespersons
SELECT DISTINCT Salesperson_ID, Salesperson_Name
FROM Sales_1NF;

cREATE TABLE Orders_3NF (
 Order_ID INT PRIMARY KEY,
 Order_Date DATE,
 Customer_ID VARCHAR(10),
 Salesperson_ID VARCHAR(10),
 FOREIGN KEY (Customer_ID)
 REFERENCES Customers(Customer_ID),
 FOREIGN KEY (Salesperson_ID)
 REFERENCES Salespersons(Salesperson_ID)
);

INSERT INTO Orders_3NF
SELECT DISTINCT
 Order_ID,
 Order_Date,
 Customer_ID,
 Salesperson_ID
FROM Sales_1NF;

SELECT * FROM Customers;

SELECT * FROM Salespersons;

SELECT * FROM Orders_3NF;

CREATE TABLE Employee_Assignment (
 Employee_ID VARCHAR(10),
 Project_ID VARCHAR(10),
 Supervisor_ID VARCHAR(10),
 PRIMARY KEY (Employee_ID, Project_ID)
);

INSERT INTO Employee_Assignment VALUES
('E01', 'P01', 'S01'),
('E02', 'P01', 'S01'),
('E03', 'P02', 'S02'),
('E04', 'P02', 'S02');

CREATE TABLE Supervisor_Project (
 Supervisor_ID VARCHAR(10) PRIMARY KEY,
 Project_ID VARCHAR(10)
);

INSERT INTO Supervisor_Project VALUES
('S01', 'P01'),
('S02', 'P02');

CREATE TABLE Employee_Supervisor (
 Employee_ID VARCHAR(10),
 Supervisor_ID VARCHAR(10),
 PRIMARY KEY (Employee_ID, Supervisor_ID)
);

INSERT INTO Employee_Supervisor VALUES
('E01', 'S01'),
('E02', 'S01'),
('E03', 'S02'),
('E04', 'S02');

SELECT
 es.Employee_ID,
 sp.Project_ID,
 es.Supervisor_ID
FROM Employee_Supervisor es
JOIN Supervisor_Project sp
 ON es.Supervisor_ID = sp.Supervisor_ID;


SELECT
 o.Order_ID,
 o.Order_Date,
 c.Customer_ID,
 c.Customer_Name,
 od.Product_ID,
 p.Product_Name,
 od.Quantity,
 p.Unit_Price,
 s.Salesperson_ID,
 s.Salesperson_Name
FROM Orders_3NF o
JOIN Customers c
 ON o.Customer_ID = c.Customer_ID
JOIN Salespersons s
 ON o.Salesperson_ID = s.Salesperson_ID
JOIN Order_Details od
 ON o.Order_ID = od.Order_ID
JOIN Products p
 ON od.Product_ID = p.Product_ID
ORDER BY o.Order_ID, od.Product_ID;

SELECT COUNT(*) AS reconstructed_rows
FROM Orders_3NF o
JOIN Customers c
 ON o.Customer_ID = c.Customer_ID
JOIN Salespersons s
 ON o.Salesperson_ID = s.Salesperson_ID
JOIN Order_Details od
 ON o.Order_ID = od.Order_ID
JOIN Products p
 ON od.Product_ID = p.Product_ID;

SHOW CREATE TABLE Customers;
SHOW CREATE TABLE Salespersons;
SHOW CREATE TABLE Orders_3NF;
SHOW CREATE TABLE Products;
SHOW CREATE TABLE Order_Details;