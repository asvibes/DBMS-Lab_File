# Experiment 6: Stored Procedures, Triggers, and Audit Logging

## Aim

To implement stored procedures, triggers, transaction handling, salary validation, employee transfers, and audit logging using MySQL.

## Objectives

* Create tables for departments, employees, and audit logs.
* Implement triggers to validate employee salaries during INSERT and UPDATE operations.
* Prevent salaries from being zero, negative, or greater than ₹2,00,000.
* Restrict salary increases exceeding 50% in a single update.
* Create a stored procedure to transfer employees between departments.
* Validate employee status, department selection, and transfer conditions.
* Use transactions, COMMIT, ROLLBACK, and exception handlers.
* Implement audit logging for employee insertions, department transfers, and salary changes.
* Test valid and invalid operations using stored procedures.

## Database Schema

The experiment uses the `company_db` database.

| Table Name    | Description                                                                       |
| ------------- | --------------------------------------------------------------------------------- |
| `departments` | Stores department IDs and unique department names.                                |
| `employees`   | Stores employee details, department assignments, salaries, and employment status. |
| `audit_log`   | Records employee insertions, department transfers, and salary changes.            |

## SQL Implementation

### 1. Table Creation

Creates the `departments`, `employees`, and `audit_log` tables with primary keys, foreign keys, unique constraints, and default values.

### 2. Triggers

The following triggers are implemented:

| Trigger                       | Purpose                                                               |
| ----------------------------- | --------------------------------------------------------------------- |
| `trg_emp_salary_check_insert` | Validates salary during employee insertion.                           |
| `trg_emp_salary_check_update` | Validates salary during updates and prevents increases exceeding 50%. |
| `trg_emp_audit_insert`        | Records new employee insertions in the audit log.                     |
| `trg_emp_audit_update`        | Records department transfers and salary changes.                      |

### 3. Stored Procedure

The `transfer_employee` procedure transfers an employee to another department after validating:

* Employee and department parameters are not NULL.
* The employee exists.
* The employee is active.
* The employee is not already assigned to the target department.

The procedure uses a transaction and exception handler to roll back unsuccessful operations.

### 4. Test Helper Procedures

* `try_transfer` executes employee transfer tests and displays errors for invalid inputs.
* `try_sql_salary` tests salary updates and captures errors raised by triggers.

### 5. Sample Data

The experiment inserts:

* 5 departments.
* 10 employees with different salaries and employment statuses.

### 6. Test Cases

The SQL script tests the following scenarios:

| Test | Description                                  | Expected Result                 |
| ---- | -------------------------------------------- | ------------------------------- |
| 1    | Valid employee transfer                      | Success                         |
| 2    | Transfer to the same department              | Error                           |
| 3    | Transfer for a nonexistent employee          | Error                           |
| 4    | Transfer to a nonexistent department         | Error                           |
| 5    | NULL employee ID                             | Error                           |
| 6    | NULL department ID                           | Error                           |
| 7    | Transfer of an inactive employee             | Error                           |
| 8    | Salary set to zero                           | Blocked                         |
| 9    | Negative salary                              | Blocked                         |
| 10   | Salary exceeding 200000                      | Blocked                         |
| 11   | Salary increase exceeding 50%                | Blocked                         |
| 12   | Valid salary increase                        | Success                         |
| 13   | Insertion with NULL salary                   | Blocked                         |
| 14   | Verify employee data after a failed transfer | Original data remains unchanged |

### 7. Audit Log Verification

The script retrieves records from `audit_log` and `employees` to verify employee details and changes made during execution.


## Conclusion

The experiment demonstrates how stored procedures and triggers can enforce business rules, validate employee salaries, manage department transfers, and maintain audit records. Transaction handling and exception handlers help maintain data consistency when operations fail.
