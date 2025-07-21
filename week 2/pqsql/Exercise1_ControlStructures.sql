SET SERVEROUTPUT ON;

DECLARE
  senior_count NUMBER := 0;
  vip_count NUMBER := 0;
  due_count NUMBER := 0;
BEGIN
  -- Scenario 1: Senior citizen discount (Age > 60)
  DBMS_OUTPUT.PUT_LINE('--- Scenario 1: Discount Eligible Customers (Age > 60) ---');
  FOR disc_rec IN (
    SELECT CUSTOMER_ID, CUST_FIRST_NAME, CUST_LAST_NAME, 
           TRUNC(MONTHS_BETWEEN(SYSDATE, DATE_OF_BIRTH) / 12) AS AGE
    FROM OE.CUSTOMERS
    WHERE TRUNC(MONTHS_BETWEEN(SYSDATE, DATE_OF_BIRTH) / 12) > 60
  ) LOOP
    DBMS_OUTPUT.PUT_LINE('Customer ' || disc_rec.CUST_FIRST_NAME || ' ' || disc_rec.CUST_LAST_NAME ||
                         ' (ID: ' || disc_rec.CUSTOMER_ID || ')s eligible for a senior citizen discount. Age: ' || disc_rec.AGE);
    senior_count := senior_count + 1;
  END LOOP;

  -- Scenario 2: VIP Customers (Available balance > 10000)
  DBMS_OUTPUT.PUT_LINE(CHR(10) || '--- Scenario 2: VIP Customers (Available Balance > $10,000) ---');
  FOR vip_rec IN (
    SELECT c.CUSTOMER_ID, c.CUST_FIRST_NAME, c.CUST_LAST_NAME, 
           c.CREDIT_LIMIT, NVL(SUM(o.ORDER_TOTAL), 0) AS USED_AMOUNT,
           (c.CREDIT_LIMIT - NVL(SUM(o.ORDER_TOTAL), 0)) AS AVAILABLE_BALANCE
    FROM OE.CUSTOMERS c
    LEFT JOIN OE.ORDERS o ON c.CUSTOMER_ID = o.CUSTOMER_ID
    GROUP BY c.CUSTOMER_ID, c.CUST_FIRST_NAME, c.CUST_LAST_NAME, c.CREDIT_LIMIT
    HAVING (c.CREDIT_LIMIT - NVL(SUM(o.ORDER_TOTAL), 0)) > 10000
  ) LOOP
    DBMS_OUTPUT.PUT_LINE('VIP Customer: ' || vip_rec.CUST_FIRST_NAME || ' ' || vip_rec.CUST_LAST_NAME ||
                         ' (ID: ' || vip_rec.CUSTOMER_ID || ') - Available Balance: $' || vip_rec.AVAILABLE_BALANCE);
    vip_count := vip_count + 1;
  END LOOP;

  -- Scenario 3: Reminders for Orders Due in next 30 days (ORDER_DATE + 30)
  DBMS_OUTPUT.PUT_LINE(CHR(10) || '--- Scenario 3: Reminder for Orders Due in Next 30 Days ---');
  FOR due_rec IN (
    SELECT o.ORDER_ID, c.CUST_FIRST_NAME, c.CUST_LAST_NAME, o.ORDER_DATE, (o.ORDER_DATE + 30) AS DUE_DATE
    FROM OE.ORDERS o
    JOIN OE.CUSTOMERS c ON o.CUSTOMER_ID = c.CUSTOMER_ID
    WHERE o.ORDER_DATE + 30 BETWEEN SYSDATE AND SYSDATE + 30
  ) LOOP
    DBMS_OUTPUT.PUT_LINE('Reminder: Order ' || due_rec.ORDER_ID || ' by ' || due_rec.CUST_FIRST_NAME || ' ' ||
                         due_rec.CUST_LAST_NAME || ' is due on ' || TO_CHAR(due_rec.DUE_DATE, 'DD-MON-YYYY'));
    due_count := due_count + 1;
  END LOOP;

  -- Final Summary
  DBMS_OUTPUT.PUT_LINE(CHR(10) || '--- Summary ---');
  DBMS_OUTPUT.PUT_LINE('Total Senior Citizen Discount Customers: ' || senior_count);
  DBMS_OUTPUT.PUT_LINE('Total VIP Customers (Available Balance > $10,000): ' || vip_count);
  DBMS_OUTPUT.PUT_LINE('Total Orders Due in Next 30 Days: ' || due_count);

  COMMIT;
END;
/