-- Drop if already exists (safe reset)
BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE accounts';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE employees';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

-- Create tables
CREATE TABLE accounts (
    account_id     NUMBER PRIMARY KEY,
    account_type   VARCHAR2(20),
    balance        NUMBER
);

CREATE TABLE employees (
    employee_id    NUMBER PRIMARY KEY,
    department_id  NUMBER,
    salary         NUMBER
);

-- Insert data
INSERT INTO accounts VALUES (1, 'savings', 10000);
INSERT INTO accounts VALUES (2, 'savings', 20000);
INSERT INTO accounts VALUES (3, 'current', 15000);

INSERT INTO employees VALUES (101, 10, 5000);
INSERT INTO employees VALUES (102, 20, 6000);
INSERT INTO employees VALUES (103, 10, 5500);

COMMIT;

-- Create procedure 1
CREATE OR REPLACE PROCEDURE ProcessMonthlyInterest IS
BEGIN
    UPDATE accounts
    SET balance = balance + (balance * 0.03)
    WHERE account_type = 'savings';
END;
/

-- Create procedure 2
CREATE OR REPLACE PROCEDURE UpdateEmployeeBonus IS
BEGIN
    UPDATE employees
    SET salary = salary + 1000
    WHERE department_id = 10;
END;
/

-- Create procedure 3
CREATE OR REPLACE PROCEDURE TransferFunds IS
BEGIN
    UPDATE accounts
    SET balance = balance - 500
    WHERE account_id = 1;

    UPDATE accounts
    SET balance = balance + 500
    WHERE account_id = 2;
END;
/

-- Call procedures
BEGIN
    ProcessMonthlyInterest;
    UpdateEmployeeBonus;
    TransferFunds;
END;
/

-- Show updated data
SELECT * FROM accounts;
SELECT * FROM employees;
