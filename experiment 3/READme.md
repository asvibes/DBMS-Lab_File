# Experiment 3
# Basic SQL Queries on Employee, Department, and Project Database

## Aim

To implement basic SQL queries using Employee, Department, and Project tables and perform selection, projection, aggregate operations, grouping, conditional operations, and sorting in MySQL.

## Objectives

* Create tables with primary key and foreign key constraints.
* Insert records into Department, Employee, Project, and Employee_Project tables.
* Perform selection and projection using SQL queries.
* Apply aggregate functions such as COUNT(), AVG(), MAX(), MIN(), and SUM().
* Group records using GROUP BY and filter groups using HAVING.
* Use CASE expressions for conditional classification.
* Sort query results using ORDER BY.
* Understand relationships between employees, departments, and projects.

## Database Schema

The database used is `EmployeeProjectDB`.

| Table Name       | Description                                                                                               |
| ---------------- | --------------------------------------------------------------------------------------------------------- |
| Department       | Stores department IDs, names, and locations.                                                              |
| Employee         | Stores employee details, including salary, hire date, department, and manager.                            |
| Project          | Stores project names, budgets, and department IDs.                                                        |
| Employee_Project | Maintains the many-to-many relationship between employees and projects, including hours worked and roles. |

## SQL Implementation

The experiment includes:

* Creating the `EmployeeProjectDB` database.
* Creating four tables with primary key and foreign key constraints.
* Inserting 5 departments, 30 employees, 8 projects, and employee-project assignment records.
* Retrieving complete records from the tables.
* Executing queries for data filtering, aggregation, grouping, conditional classification, and sorting.

## Queries Performed

| Query Type               | Description                                                                              |
| ------------------------ | ---------------------------------------------------------------------------------------- |
| Selection                | Retrieves employees whose salary is greater than 60,000 using WHERE.                     |
| Projection               | Displays selected columns, such as employee names and salaries.                          |
| Selection and Projection | Retrieves employee names and salaries for employees earning more than 60,000.            |
| Aggregate Functions      | Uses COUNT(), AVG(), MAX(), MIN(), and SUM() to analyze employee data.                   |
| GROUP BY                 | Calculates the average salary for each department.                                       |
| GROUP BY with JOIN       | Displays department names, employee counts, and average salaries.                        |
| HAVING                   | Displays departments whose average salary is greater than 60,000.                        |
| CASE Expression          | Classifies employees into salary categories: High Salary, Medium Salary, and Low Salary. |
| CASE with Department     | Classifies employees into Senior, Mid-Level, and Junior categories based on salary.      |
| ORDER BY                 | Sorts employees by salary in descending order.                                           |

## Conclusion

The experiment demonstrates the use of basic SQL commands and aggregate functions to retrieve, filter, group, classify, analyze, and sort data in a relational database. It also illustrates the relationships between employees, departments, and projects through primary and foreign key constraints.
