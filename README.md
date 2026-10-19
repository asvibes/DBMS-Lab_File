# DBMS Practical File

------------------------------------------------------------------------

## About This Repository

This repository contains the SQL scripts, ER diagram, sample datasets,
query results, execution plans, and practical evidence for the ten DBMS
laboratory experiments listed in the practical syllabus.

The experiments cover ER modelling, relational schema design, SQL
queries, joins and subqueries, views, recursive CTEs, stored procedures,
triggers, normalization, transactions, indexing, and query optimization.

## Repository Structure

Keep each experiment in a separate folder. Example:

``` text
DBMS-Practical/
├── README.md
├── Experiment-1/
│   ├── er-diagram.png
│   └── er-diagram-hand-drawn.png
├── Experiment-2/
│   ├── experiment2.sql
│   └── output/
├── Experiment-3/
│   ├── experiment3.sql
│   └── output/
├── Experiment-4/
│   ├── experiment4.sql
│   └── output/
├── Experiment-5/
│   ├── experiment5.sql
│   └── output/
├── Experiment-6/
│   ├── experiment6.sql
│   └── output/
├── Experiment-7/
│   ├── experiment7.sql
│   └── output/
├── Experiment-8/
│   ├── experiment8.sql
│   └── output/
├── Experiment-9/
│   ├── experiment9.sql
│   └── output/
└── Experiment-10/
    ├── experiment10.sql
    └── output/
```
------------------------------------------------------------------------

## List of Experiments

### Experiment 1 --- ER Diagram for an Indian E-Commerce Platform

**Question:** Design an ER diagram for an Indian e-commerce platform
with entities Customer, Product, Order, OrderItem, Seller, Category,
Payment, Delivery, and Address. Specify primary keys, composite and
multivalued attributes, weak entities, Product specialization, and
participation constraints.

**Work to include:** - ER diagram with entities, attributes, keys,
relationships, cardinalities, and participation constraints. - Composite
attribute example: address split into house/street/city/state/PIN
code. - Multivalued attribute example: customer phone numbers. - Weak
entity and identifying relationship, such as OrderItem depending on
Order. - Product specialization, such as physical and digital
products. - Labelled primary keys and foreign keys where applicable.

### Experiment 2 --- Relational Schema, Constraints, and Referential Integrity

**Question:** Convert the ER diagram into a relational schema. Write
complete MySQL `CREATE TABLE` statements with primary keys, foreign
keys, `NOT NULL`, `UNIQUE`, `ON DELETE CASCADE`, and
`ON DELETE SET NULL` constraints. Insert sample data and demonstrate
referential integrity violations.

**Work to include:** - Relational schema derived from Experiment 1. -
MySQL table creation in dependency order. - Primary-key, foreign-key,
`NOT NULL`, and `UNIQUE` constraints. - Appropriate `ON DELETE CASCADE`
and `ON DELETE SET NULL` examples. - Sample records and verification
queries. - Clearly labelled invalid statements demonstrating foreign-key
violations and the expected errors.

### Experiment 3 --- Employee, Department, Project, and Basic SQL

**Question:** Create an Employee--Department--Project schema. Insert at
least 30 employees across 5 departments and 8 projects. Write SQL
queries demonstrating selection, projection, aggregates, `GROUP BY`,
`HAVING`, `CASE` expressions, and `ORDER BY`.

**Work to include:** - Table definitions and relationships. - At least
30 employees, 5 departments, and 8 projects. - Selection with `WHERE`
and projection using selected columns. - Aggregate functions: `COUNT`,
`SUM`, `AVG`, `MIN`, and `MAX`. - `GROUP BY`, `HAVING`, `CASE`, and
`ORDER BY`. - Query results or screenshots.

### Experiment 4 --- Joins, Subqueries, Set Operations, and EXPLAIN

**Question:** Using the Employee schema, write queries with
`INNER JOIN`, `LEFT JOIN`, self-join, three-way join, correlated
subqueries, `EXISTS`, and simulated `INTERSECT` and `EXCEPT`. Compare
execution plans using `EXPLAIN`.

**Work to include:** - `INNER JOIN`, `LEFT JOIN`, self-join, and
three-table join examples. - Correlated subquery and `EXISTS`
examples. - Simulated `INTERSECT` and `EXCEPT` using constructs such as
`EXISTS` and `NOT EXISTS`. - `EXPLAIN` output and a short interpretation
of access type, selected index, estimated rows, and extra operations.

### Experiment 5 --- Views and Recursive CTE

**Question:** Create SQL views for department salary summary and
employee hierarchy. Test updatability of views. Implement a recursive
CTE to display reporting chains.

**Work to include:** - Department salary-summary view. - Employee
hierarchy view showing employees and managers. - Tests for querying and
updating views, with explanations of any restrictions. - Recursive CTE
with an anchor member and recursive member. - Output showing reporting
levels or reporting chains. - Check for invalid manager references or
hierarchy cycles.

### Experiment 6 --- Stored Procedure, Triggers, and Audit Logging

**Question:** Create a stored procedure
`transfer_employee(emp_id, new_dept_id)` with validation and error
handling. Implement triggers for salary validation and audit logging.
Test edge cases.

**Work to include:** - Stored procedure for transferring an employee
between departments. - Validation that the employee and target
department exist. - Error handling for invalid inputs, using suitable
MySQL stored-program statements. - Salary validation trigger. - Audit
table and trigger that records salary changes. - Tests for successful
transfers, invalid IDs, invalid salaries, and audit entries.

### Experiment 7 --- Normalization from UNF to 3NF and BCNF

**Question:** Given a denormalized Sales table, identify functional
dependencies and normalize step-by-step from UNF to 3NF and BCNF. Verify
lossless join and dependency preservation using SQL queries.

**Work to include:** - Denormalized Sales table and sample data. -
Functional dependencies and candidate keys, with assumptions stated. -
Step-by-step conversion through UNF, 1NF, 2NF, 3NF, and BCNF where
applicable. - Final relations with primary and foreign keys. -
Explanation of lossless join and dependency preservation. - SQL queries
to reconstruct and verify the decomposed data.

### Experiment 8 --- Transactions and Concurrency

**Question:** Implement banking-style transactions using `BEGIN`,
`COMMIT`, `ROLLBACK`, and `SAVEPOINT`. Simulate partial failures.
Demonstrate isolation levels and concurrency anomalies using two
sessions.

**Work to include:** - Bank-account table and sample balances. -
Successful money transfer using a transaction and `COMMIT`. - Failed
transaction using `ROLLBACK`. - Partial rollback using `SAVEPOINT` and
`ROLLBACK TO SAVEPOINT`. - Two-session demonstrations of relevant
concurrency behavior. - Isolation level, SQL statement sequence,
observed results, and explanation. - Use InnoDB and a test database.

### Experiment 9 --- Railway Booking Indexing and Performance

**Question:** Create a Railway Booking table with at least 5,000
records. Benchmark query performance before and after creating single
and composite indexes. Use `EXPLAIN` to compare execution plans.

**Work to include:** - Railway Booking table and at least 5,000
records. - Representative filtering and sorting queries. - Baseline
query execution times and `EXPLAIN` plans. - Single-column and composite
indexes. - Repeated tests after indexing. - Before-and-after comparison
table and explanation of observed changes.

### Experiment 10 --- Query Optimization

**Question:** Generate a dataset with at least 10,000 rows. Write five
slow queries, analyze using `EXPLAIN`, optimize using indexing and query
rewriting, and compare execution time before and after optimization.

**Work to include:** - Dataset containing at least 10,000 rows. - Five
queries that can be meaningfully optimized. - Baseline SQL, `EXPLAIN`
output, and execution time. - Optimized queries using appropriate
indexes or query rewrites. - Before-and-after timing and execution-plan
comparison. - Verification that optimized queries return equivalent
results.

## Submission Record


| Experiment    | Date of Submission |
| :------------ | :----------------- |
| Experiment 1  | 24.08.2026         |
| Experiment 2  | 24.08.2026         |
| Experiment 3  | 01.10.2026         |
| Experiment 4  | 01.10.2026         |
| Experiment 5  | 01.10.2026         |
| Experiment 6  | 01.10.2026         |
| Experiment 7  | —                  |
| Experiment 8  | —                  |
| Experiment 9  | —                  |
| Experiment 10 | —                  |




**End of DBMS Practical README**
