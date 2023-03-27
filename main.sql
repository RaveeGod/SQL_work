-- I'm a restaurant owner, create 5 tables
-- 1 fact, 4 dimension
-- Search google, how to add foreign key
-- Write SQL 3-5 queries to analyze data
-- Subquery or WITH
-- sqlite command, edit view
  
CREATE TABLE STAFF (
  STAFF_ID INT PRIMARY KEY,
  STAFF_NAME TEXT,
  STAFF_GENDER TEXT,
  STAFF_AGE INT 
);

INSERT INTO STAFF values
  (1, 'Ravee', 'M', 20),
  (2, 'Tom', 'M', 25),
  (3, 'Mary', 'F', 23),
  (4, 'David', 'M', 30);

CREATE TABLE PRODUCT (
  PRODUCT_ID INT PRIMARY KEY,
  PRODUCT_NAME TEXT,
  PRODUCT_PRICE REAL 
);

INSERT INTO PRODUCT values
  (1,'Chicken Fried', 400),
  (2,'Mashed Potato', 100),
  (3,'French Fries',250),
  (4,'Salad',150),
  (5,'Fruits',80),
  (6,'Fish and Seafood',300);

CREATE TABLE CUSTOMER (
  CUSTOMER_ID INT PRIMARY KEY,
  CUSTOMER_TYPE TEXT
);

INSERT INTO CUSTOMER values
  (1,'Family'),
  (2,'Couple'),
  (3,'Other');

CREATE TABLE PAYMENT (
  PAYMENT_ID INT PRIMARY KEY,
  PAYMENT_TYPE TEXT
);

INSERT INTO PAYMENT values
  (1,'Cash'),
  (2,'Credit Card'),
  (3,'Bank Transfer');

CREATE TABLE Orders (
  ORDER_ID INT PRIMARY KEY,
  ORDER_DATE TEXT,
  SALES REAL,
  STAFF_ID INT,
  PRODUCT_ID INT, 
  CUSTOMER_ID INT, 
  PAYMENT_ID INT
  /* FOREIGN KEY (STAFF_ID) REFERENCES STAFF(STAFF_ID),
  FOREIGN KEY (PRODUCT_ID) REFERENCES PRODUCT(PRODUCT_ID),
  FOREIGN KEY (CUSTOMER_ID) REFERENCES CUSTOMER(CUSTOMER_ID),
  FOREIGN KEY (PAYMENT_ID) REFERENCES PAYMENT(PAYMENT_ID) */
);

INSERT INTO Orders values 
  (1,'2022-08-23',400,4,1,1,3),
  (2,'2022-03-24',250,2,3,1,1),
  (3,'2022-08-25',100,3,2,3,2),
  (4,'2022-08-26',150,4,4,2,1),
  (5,'2022-08-27',80,1,5,3,1),
  (6,'2022-08-28',250,1,3,3,2),
  (7,'2022-08-29',400,3,1,3,3),
  (8,'2022-08-30',300,2,6,1,2);

.mode markdown
.header on

  select * FROM Orders;

  
   select
    O.ORDER_ID,
    O.ORDER_DATE,
    O.SALES,
    ST.STAFF_NAME,
    CU.CUSTOMER_TYPE,
    PA.PAYMENT_TYPE
  FROM Orders AS O 
  JOIN STAFF AS ST ON O.STAFF_ID = ST.STAFF_ID
  JOIN PRODUCT AS PR ON O.PRODUCT_ID = PR.PRODUCT_ID
  JOIN CUSTOMER AS CU ON O.CUSTOMER_ID = CU.CUSTOMER_ID
  JOIN PAYMENT AS PA ON O.PAYMENT_ID = PA.PAYMENT_ID;

  
-- Top 3 
  select 
    O.ORDER_DATE,
    PR.PRODUCT_NAME,
    SUM(SALES) AS SALES
  FROM Orders AS O
  JOIN PRODUCT AS PR ON O.PRODUCT_ID = PR.PRODUCT_ID
  WHERE ORDER_DATE BETWEEN '2022-08-23' AND '2022-08-30'
  GROUP BY ORDER_DATE
  ORDER BY SUM(SALES) DESC
  LIMIT 3 ; 
  
-- sub query
  select 
    Food_types,
    COUNT(*) AS n_sub
  FROM (
    select
      PRODUCT_ID,
      CASE
        WHEN PRODUCT_ID IN (1,2,3) THEN 'Fast food'
        WHEN PRODUCT_ID IN (4,5) THEN 'Healthy food'
        ELSE 'Seafood'
      END AS Food_types
    FROM Orders
  ) AS sub
  GROUP BY 1
  ORDER BY 2 DESC;

  select 
    Payment_types,
    COUNT(*) AS n_sub
  FROM (
    select
      PAYMENT_ID,
      CASE
        WHEN PAYMENT_ID IN (1) THEN 'Cash'
        WHEN PAYMENT_ID IN (2) THEN 'Credit Card'
        ELSE 'Bank Transfer'
      END AS Payment_types
    FROM Orders
  ) AS sub
  GROUP BY 1
  ORDER BY 2 DESC;


  select SUM(SALES) AS Total_SALES
    FROM Orders;


  select STAFF_NAME FROM STAFF
  ;

  WITH sub AS (
    select 
      *
    FROM Orders AS O
    JOIN STAFF AS ST ON O.STAFF_ID = ST.STAFF_ID
    WHERE STAFF_GENDER = 'M'
  )
    
  select
    DISTINCT STAFF_NAME,
    SUM(SALES) AS Total_Sales_By_Ravee
  FROM sub
  WHERE STAFF_ID = 1;
  
  
  
    

  

  
