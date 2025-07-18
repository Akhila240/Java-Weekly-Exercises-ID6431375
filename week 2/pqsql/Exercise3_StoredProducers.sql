-- Drop tables directly (no EXECUTE IMMEDIATE)
DROP TABLE accounts PURGE;
DROP TABLE employees PURGE;
-- If table doesn't exist, ignore the error and re-run script

-- Create tables
CREATE TABLE accounts (
    account_id NUMBER PRIMARY KEY,
    account_type VARCHAR2(20),
    balance NUMBER
);

CREATE TABLE employees (
    employee_id NUMBER PRIMARY KEY,
    department_id NUMBER,
    salary NUMBER
);

-- Insert test data
INSERT INTO accounts VALUES (101, 'savings', 10000);
INSERT INTO accounts VALUES (102, 'savings', 5000);
INSERT INTO accounts VALUES (103, 'current', 2000);

INSERT INTO employees VALUES (1, 10, 30000);
INSERT INTO employees VALUES (2, 10, 40000);
INSERT INTO employees VALUES (3, 20, 35000);

COMMIT;

-- Enable DBMS Output
BEGIN
  DBMS_OUTPUT.PUT_LINE('✅ Setup complete.');
END;
/
-- Scenario 1: Apply interest
BEGIN
    UPDATE accounts
    SET balance = balance + (balance * 0.01)
    WHERE account_type = 'savings';

    DBMS_OUTPUT.PUT_LINE('✅ Interest applied to savings accounts.');
END;
/

-- Scenario 2: Employee bonus
DECLARE
    p_dept_id NUMBER := 10;
    p_bonus_pct NUMBER := 15;
BEGIN
    UPDATE employees
    SET salary = salary + (salary * (p_bonus_pct / 100))
    WHERE department_id = p_dept_id;

    DBMS_OUTPUT.PUT_LINE('✅ Bonus of ' || p_bonus_pct || '% applied to department ' || p_dept_id);
END;
/

-- Scenario 3: Transfer funds
DECLARE
    v_balance NUMBER;
    p_from_account NUMBER := 101;
    p_to_account NUMBER := 102;
    p_amount NUMBER := 500;
BEGIN
    SELECT balance INTO v_balance FROM accounts
    WHERE account_id = p_from_account FOR UPDATE;

    IF v_balance < p_amount THEN
        RAISE_APPLICATION_ERROR(-20001, '❌ Not enough funds.');
    END IF;

    UPDATE accounts
    SET balance = balance - p_amount
    WHERE account_id = p_from_account;

    UPDATE accounts
    SET balance = balance + p_amount
    WHERE account_id = p_to_account;

    DBMS_OUTPUT.PUT_LINE('✅ ₹' || p_amount || ' transferred from ' || p_from_account || ' to ' || p_to_account);
END;
/
