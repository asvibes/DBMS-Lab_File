# Experiment 5: SQL Views and Recursive CTE

## Aim

To create and manipulate SQL views for department salary summaries and employee hierarchies, test view updatability, and implement recursive Common Table Expressions (CTEs) to display employee reporting chains using MySQL.

## Objectives

* Create a department salary summary using employee and department data.
* Retrieve and analyze department salary statistics.
* Establish manager-employee relationships using a self-referencing foreign key.
* Create a view displaying employee and manager information.
* Create a simple employee view and test its updatability.
* Test the limitations of updating aggregate-based views.
* Implement recursive CTEs to display employee reporting hierarchies.
* Retrieve the reporting chain for a specific employee.

## Database Used

`EmployeeProjectDB` — the database created in Experiment 3.

## SQL Implementation

### 1. Department Salary Summary

Creates the `Department_Salary_Summary` table using department and employee data.

The summary includes:

* Total number of employees in each department.
* Total salary expenditure.
* Average salary.
* Highest salary.
* Lowest salary.

### 2. Querying the Salary Summary

Retrieves department names and average salaries for departments whose average salary exceeds 85,000.

### 3. Employee Hierarchy

Adds a `manager_id` column to the Employee table and establishes a self-referencing foreign key to represent reporting relationships.

### 4. Employee Hierarchy View

Creates the `Employee_Hierarchy` view to display:

* Employee ID and name.
* Manager ID and name.
* Employee salary.
* Department ID.

A LEFT JOIN ensures that employees without assigned managers can also appear in the view.

### 5. Testing View Updatability

Creates the `Employee_Basic` view containing employee ID, name, salary, and department ID.

The experiment updates an employee's salary through this view and verifies the change in the underlying Employee table.

### 6. Testing Non-Updatability of Aggregate Data

Attempts to update the average salary in `Department_Salary_Summary` to demonstrate the limitations of modifying aggregate results directly.

### 7. Recursive CTE: Employee Reporting Hierarchy

Uses a recursive CTE named `EmployeeChain` to retrieve employees starting from those without managers.

The result displays:

* Employee ID and name.
* Manager ID.
* Reporting level.
* Complete reporting chain from the top-level employee to each subordinate.

### 8. Recursive CTE for a Specific Employee

Uses `ReportingChain` to retrieve the reporting relationships for employee ID 101 by following the employee's manager IDs.


## Conclusion

The experiment demonstrates how SQL views simplify data retrieval, how view updatability depends on the underlying query structure, and how recursive CTEs retrieve hierarchical relationships in an employee database.
