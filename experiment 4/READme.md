# Experiment 4
# Joins, Subqueries, Set Operations, and Query Execution Plans

## Aim

To implement and analyze SQL joins, correlated subqueries, EXISTS, simulated INTERSECT and EXCEPT operations, and query execution plans using the EmployeeProjectDB database in MySQL.

## Objectives

* Perform INNER JOIN, LEFT JOIN, SELF JOIN, and multi-table joins.
* Retrieve records using correlated subqueries.
* Use EXISTS to check for matching records.
* Simulate INTERSECT and EXCEPT operations using EXISTS and NOT EXISTS.
* Examine query execution plans using EXPLAIN.
* Create indexes to support query performance.
* Understand how joins and subqueries retrieve related data from multiple tables.

## Database Used

`EmployeeProjectDB`

The experiment uses the following tables:

| Table Name       | Description                                            |
| ---------------- | ------------------------------------------------------ |
| Employee         | Stores employee information and manager relationships. |
| Department       | Stores department details.                             |
| Project          | Stores project information.                            |
| Employee_Project | Maps employees to their assigned projects.             |

## SQL Implementation

The SQL script includes the following operations:

### 1. Joins

* **INNER JOIN:** Retrieves employees and their corresponding department names.
* **LEFT JOIN:** Displays all departments, including departments without employees.
* **SELF JOIN:** Displays employees alongside their managers.
* **Multi-table JOIN:** Retrieves employee names, department names, and project names.

### 2. Subqueries

* **Correlated Subquery:** Finds employees whose salaries are greater than their respective department's average salary.
* **EXISTS:** Retrieves employees who are assigned to at least one project.

### 3. Set Operations

* **Simulated INTERSECT:** Retrieves employees belonging to Department 1 who are assigned to Project 101.
* **Simulated EXCEPT:** Retrieves employees belonging to Department 1 who are not assigned to Project 101.

These operations are implemented using EXISTS and NOT EXISTS.

### 4. Query Execution Plans

The script includes queries for examining the execution plans of:

* INNER JOIN
* LEFT JOIN
* Correlated subqueries
* EXISTS

The EXPLAIN command can be used to inspect how MySQL executes queries.

### 5. Indexing

The following indexes are created:

| Index Name                 | Table            | Indexed Column |
| -------------------------- | ---------------- | -------------- |
| `idx_employee_dept`        | Employee         | DeptID         |
| `idx_employee_manager`     | Employee         | ManagerID      |
| `idx_employee_project_emp` | Employee_Project | EmpID          |

These indexes may improve the performance of queries that filter or join using the indexed columns.

## Conclusion

The experiment demonstrates how joins and subqueries retrieve related information from relational tables. It also illustrates how EXISTS and NOT EXISTS can simulate set operations and how EXPLAIN and indexes help analyze and potentially improve query performance.
