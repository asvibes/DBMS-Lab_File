
DROP DATABASE IF EXISTS company_db;

CREATE DATABASE company_db;

USE company_db;

-----------------------------------------------------

-- 1. TABLES

-----------------------------------------------------

CREATE TABLE departments (

    dept_id  INT PRIMARY KEY,

    dept_name VARCHAR(50) NOT NULL UNIQUE

);

CREATE TABLE employees (

    emp_id   INT PRIMARY KEY,

    emp_name VARCHAR(50) NOT NULL,

    dept_id  INT NOT NULL,

    salary   DECIMAL(10,2) NOT NULL,

    status   ENUM('ACTIVE','INACTIVE') NOT NULL DEFAULT 'ACTIVE',

    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)

);

CREATE TABLE audit_log (

    audit_id    INT AUTO_INCREMENT PRIMARY KEY,

    emp_id      INT,

    action_type VARCHAR(30),          -- INSERT / DEPT_TRANSFER / SALARY_CHANGE

    old_dept_id INT,

    new_dept_id INT,

    old_salary  DECIMAL(10,2),

    new_salary  DECIMAL(10,2),

    changed_by  VARCHAR(100),

    changed_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP

);

-----------------------------------------------------

2. TRIGGERS

-- -----------------------------------------------------

DELIMITER //

-- 2a. Salary validation on INSERT

CREATE TRIGGER trg_emp_salary_check_insert

BEFORE INSERT ON employees

FOR EACH ROW

BEGIN

    IF NEW.salary IS NULL OR NEW.salary <= 0 THEN

        SIGNAL SQLSTATE '45000' 

        SET MESSAGE_TEXT = 'Salary must be greater than 0';

    END IF;

    IF NEW.salary > 200000 THEN

        SIGNAL SQLSTATE '45000' 

        SET MESSAGE_TEXT = 'Salary cannot exceed 200000';

    END IF;

END;

-- 2b. Salary validation on UPDATE (also blocks >50% raise in one go)

CREATE TRIGGER trg_emp_salary_check_update

BEFORE UPDATE ON employees

FOR EACH ROW

BEGIN

    IF NEW.salary IS NULL OR NEW.salary <= 0 THEN

        SIGNAL SQLSTATE '45000' 

        SET MESSAGE_TEXT = 'Salary must be greater than 0';

    END IF;

    IF NEW.salary > 200000 THEN

        SIGNAL SQLSTATE '45000' 

        SET MESSAGE_TEXT = 'Salary cannot exceed 200000';

    END IF;

    IF NEW.salary > OLD.salary * 1.5 THEN

        SIGNAL SQLSTATE '45000' 

        SET MESSAGE_TEXT = 'Salary increase cannot be more than 50%';

    END IF;

END;

-- 2c. Audit: new employee

CREATE TRIGGER trg_emp_audit_insert

AFTER INSERT ON employees

FOR EACH ROW

BEGIN

    INSERT INTO audit_log (emp_id, action_type, new_dept_id, new_salary, changed_by)

    VALUES (NEW.emp_id, 'INSERT', NEW.dept_id, NEW.salary, USER());

END;

-- 2d. Audit: department or salary change

DROP TRIGGER IF EXISTS trg_emp_audit_update;

CREATE TRIGGER trg_emp_audit_update

AFTER UPDATE ON employees

FOR EACH ROW

BEGIN

    IF OLD.dept_id <> NEW.dept_id THEN

        INSERT INTO audit_log (emp_id, action_type, old_dept_id, new_dept_id, changed_by)

        VALUES (NEW.emp_id, 'DEPT_TRANSFER', OLD.dept_id, NEW.dept_id, USER());

    END IF;

    IF OLD.salary <> NEW.salary THEN

        INSERT INTO audit_log (emp_id, action_type, old_salary, new_salary, changed_by)

        VALUES (NEW.emp_id, 'SALARY_CHANGE', OLD.salary, NEW.salary, USER());

    END IF;

END;

-- -- -----------------------------------------------------

-- -- 3. STORED PROCEDURE: transfer_employee

-- -- -----------------------------------------------------

DROP PROCEDURE IF EXISTS transfer_employee;

DROP PROCEDURE IF EXISTS transfer_employee;

CREATE PROCEDURE transfer_employee(IN p_emp_id INT, IN p_new_dept_id INT)

BEGIN

    -- 1. Declare all variables first (uncommented)

    DECLARE v_current_dept INT;

    DECLARE v_status VARCHAR(10);

    -- 2. Declare handlers after variables

    DECLARE EXIT HANDLER FOR SQLEXCEPTION 

    BEGIN

        ROLLBACK;

        RESIGNAL;

    END;

    -- 3. Validation 1: NULL parameters

    IF p_emp_id IS NULL OR p_new_dept_id IS NULL THEN

        SIGNAL SQLSTATE '45000' 

            SET MESSAGE_TEXT = 'emp_id and new_dept_id cannot be NULL';

    END IF;

    -- 4. Start transaction and check employee existence

    DROP PROCEDURE IF EXISTS transfer_employee;

CREATE PROCEDURE transfer_employee(IN p_emp_id INT, IN p_new_dept_id INT)

BEGIN

    DECLARE v_current_dept INT;

    DECLARE v_status VARCHAR(10);

    DECLARE EXIT HANDLER FOR SQLEXCEPTION 

    BEGIN

        ROLLBACK;

        RESIGNAL;

    END;

    -- Validation 1: NULL parameters

    IF p_emp_id IS NULL OR p_new_dept_id IS NULL THEN

        SIGNAL SQLSTATE '45000' 

        SET MESSAGE_TEXT = 'emp_id and new_dept_id cannot be NULL';

    END IF;

    -- Start transaction and check employee existence

    START TRANSACTION;

    SELECT dept_id, status INTO v_current_dept, v_status

    FROM employees

    WHERE emp_id = p_emp_id

    FOR UPDATE;

    IF v_current_dept IS NULL THEN

        SIGNAL SQLSTATE '45000' 

        SET MESSAGE_TEXT = 'Employee does not exist';

    END IF;

    -- Validation 2: Check if employee is active

    IF v_status <> 'ACTIVE' THEN

        SIGNAL SQLSTATE '45000' 

        SET MESSAGE_TEXT = 'Cannot transfer inactive employee';

    END IF;

    -- Validation 3: Check if already in the target department

    IF v_current_dept = p_new_dept_id THEN

        SIGNAL SQLSTATE '45000' 

        SET MESSAGE_TEXT = 'Employee is already in this department';

    END IF;

    -- Perform the transfer update

    UPDATE employees 

    SET dept_id = p_new_dept_id 

    WHERE emp_id = p_emp_id;

    COMMIT;

END;

DROP PROCEDURE IF EXISTS transfer_employee;

CREATE PROCEDURE transfer_employee(IN p_emp_id INT, IN p_new_dept_id INT)

BEGIN

    DECLARE v_current_dept INT;

    DECLARE v_status VARCHAR(10);

    DECLARE EXIT HANDLER FOR SQLEXCEPTION 

    BEGIN

        ROLLBACK;

        RESIGNAL;

    END;

    -- Validation 1: NULL parameters

    IF p_emp_id IS NULL OR p_new_dept_id IS NULL THEN

        SIGNAL SQLSTATE '45000' 

        SET MESSAGE_TEXT = 'emp_id and new_dept_id cannot be NULL';

    END IF;

    -- Start transaction and check employee existence

    START TRANSACTION;

    SELECT dept_id, status INTO v_current_dept, v_status

    FROM employees

    WHERE emp_id = p_emp_id

    FOR UPDATE;

    IF v_current_dept IS NULL THEN

        SIGNAL SQLSTATE '45000' 

        SET MESSAGE_TEXT = 'Employee does not exist';

    END IF;

    -- Validation 2: Check if employee is active

    IF v_status <> 'ACTIVE' THEN

        SIGNAL SQLSTATE '45000' 

        SET MESSAGE_TEXT = 'Cannot transfer inactive employee';

    END IF;

    -- Validation 3: Check if already in the target department

    IF v_current_dept = p_new_dept_id THEN

        SIGNAL SQLSTATE '45000' 

        SET MESSAGE_TEXT = 'Employee is already in this department';

    END IF;

    -- Perform the transfer update

    UPDATE employees 

    SET dept_id = p_new_dept_id 

    WHERE emp_id = p_emp_id;

    COMMIT;

    SELECT CONCAT('Employee ', p_emp_id, ' moved to dept ', p_new_dept_id) AS result;

END;

-- -----------------------------------------------------

-- 4. TEST HELPER: runs a call and prints error instead of stopping

-----------------------------------------------------

DROP PROCEDURE IF EXISTS try_transfer;

CREATE PROCEDURE try_transfer(IN p_test VARCHAR(60), IN p_emp INT, IN p_dept INT)

BEGIN

    DECLARE v_msg TEXT;

    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION 

    BEGIN

        GET DIAGNOSTICS CONDITION 1 v_msg = MESSAGE_TEXT;

        SELECT p_test AS test, 'FAILED (expected for bad input)' AS outcome, v_msg AS message;

    END;

    CALL transfer_employee(p_emp, p_dept);

END;

DROP PROCEDURE IF EXISTS try_sql_salary;

CREATE PROCEDURE try_sql_salary (IN p_test VARCHAR(60), IN p_emp INT, IN p_salary DECIMAL(12,2))

BEGIN

    DECLARE v_msg TEXT;

    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION 

    BEGIN

        GET DIAGNOSTICS CONDITION 1 v_msg = MESSAGE_TEXT;

        SELECT p_test AS test, 'BLOCKED by trigger' AS outcome, v_msg AS message;

    END;

    UPDATE employees 

    SET salary = p_salary 

    WHERE emp_id = p_emp;

END;

DELIMITER ;

-- -----------------------------------------------------

-- 5. SAMPLE DATA

-- -----------------------------------------------------

INSERT INTO departments (dept_id, dept_name) VALUES

(1, 'HR'),

(2, 'IT'),

(3, 'Finance'),

(4, 'Marketing'),

(5, 'Sales');

INSERT INTO employees (emp_id, emp_name, dept_id, salary, status) VALUES

(101, 'Asha',   1,  50000.00, 'ACTIVE'),

(102, 'Ravi',   2,  60000.00, 'ACTIVE'),

(103, 'Meena',  3,  55000.00, 'INACTIVE'),

(104, 'Suresh', 2,  75000.00, 'ACTIVE'),

(105, 'Priya',  4,  48000.00, 'ACTIVE'),

(106, 'Karan',  5,  52000.00, 'ACTIVE'),

(107, 'Neha',   3,  90000.00, 'ACTIVE'),

(108, 'Amit',   1,  45000.00, 'ACTIVE'),

(109, 'Divya',  5,  58000.00, 'INACTIVE'),

(110, 'Rohit',  4, 120000.00, 'ACTIVE');

-- -----------------------------------------------------

-- 6. TESTS

-- -----------------------------------------------------

-- Test 1: valid transfer (HR -> IT)            EXPECT: success

CALL transfer_employee(101, 2);

-- Test 2: same department                      EXPECT: error

CALL try_transfer('T2 same department', 101, 2);

-- Test 3: employee does not exist              EXPECT: error

CALL try_transfer('T3 unknown employee', 999, 2);

-- Test 4: department does not exist            EXPECT: error

CALL try_transfer('T4 unknown department', 101, 99);

-- Test 5: NULL employee                        EXPECT: error

CALL try_transfer('T5 NULL emp_id', NULL, 2);

-- Test 6: NULL department                      EXPECT: error

CALL try_transfer('T6 NULL dept_id', 101, NULL);

-- Test 7: inactive employee                    EXPECT: error

CALL try_transfer('T7 inactive employee', 103, 1);

-- Test 8: salary = 0                           EXPECT: blocked

CALL try_sql_salary('T8 zero salary', 102, 0);

-- Test 9: negative salary                      EXPECT: blocked

CALL try_sql_salary('T9 negative salary', 102, -500);

-- Test 10: salary above 200000                 EXPECT: blocked

CALL try_sql_salary('T10 salary too high', 102, 250000);

-- Test 11: raise over 50%                      EXPECT: blocked

CALL try_sql_salary('T11 raise over 50%', 102, 100000);

-- Test 12: valid raise (60000 -> 66000)        EXPECT: success

CALL try_sql_salary('T12 valid raise', 102, 66000);

-- Test 13: salary NULL via direct insert       EXPECT: blocked

Test 13: salary NULL via direct insert       EXPECT: blocked 

(run manually, stops the script if uncommented)

INSERT INTO employees VALUES (200, 'Test', 1, NULL, 'ACTIVE');

-- Test 14: failed transfer must not change data

SELECT emp_id, dept_id FROM employees WHERE emp_id = 101;   -- still dept 2

-----------------------------------------------------

-- 7. VERIFY AUDIT LOG

-----------------------------------------------------

Expected: 10 INSERT rows, 1 DEPT_TRANSFER (101: 1->2), 1 SALARY_CHANGE (102)

SELECT * FROM audit_log ORDER BY audit_id;

SELECT * FROM employees; remove the comnsts donot modify anything