----------	question 1-------------
SELECT * FROM SALES.CUSTOMERS   ORDER BY FIRST_NAME DESC

---------------QUESTION 2------------
SELECT FIRST_NAME,LAST_NAME,CITY FROM SALES.CUSTOMERS
 ORDER BY CITY,FIRST_NAME

 -----------------QUESTION 3------------
 SELECT TOP(3) LIST_PRICE FROM PRODUCTION.PRODUCTS
 ORDER BY LIST_PRICE DESC

 -----------QUESTION 4---------
 SELECT * FROM PRODUCTION.PRODUCTS WHERE LIST_PRICE > 300 AND MODEL_YEAR ='2018'

 -----------QUESTION 5---------
  SELECT * FROM PRODUCTION.PRODUCTS WHERE LIST_PRICE > 3000 OR MODEL_YEAR ='2018'

  -----------QUESTION 6---------
   SELECT * FROM PRODUCTION.PRODUCTS WHERE LIST_PRICE BETWEEN 1899 AND 1999.99

-----------QUESTION 7---------
 SELECT * FROM PRODUCTION.PRODUCTS WHERE LIST_PRICE IN (299.99,466.99,489.99)

 -----------QUESTION 8---------
 SELECT * FROM SALES.CUSTOMERS WHERE LAST_NAME  LIKE '[ABC]%'

 -----------QUESTION 9---------
  SELECT * FROM SALES.CUSTOMERS WHERE FIRST_NAME NOT LIKE 'A%'

   -----------QUESTION 10---------
   SELECT STATE,CITY,COUNT(CUSTOMER_ID) FROM SALES.CUSTOMERS GROUP BY STATE,CITY

   -----------QUESTION 11---------
   SELECT CUSTOMER_ID,YEAR(ORDER_DATE) 'YEAR' ,COUNT(ORDER_ID) 'ORDER COUNT'
   FROM SALES.ORDERS
   GROUP BY CUSTOMER_ID,YEAR(ORDER_DATE)


-----------QUESTION 12----------
SELECT CATEGORY_ID,MAX(LIST_PRICE) 'MAX_LIST_PRICE',
MIN(LIST_PRICE) 'MIN_LIST_PRICE' FROM PRODUCTION.products
GROUP BY CATEGORY_ID
HAVING MAX(LIST_PRICE) > 4000 OR MIN(LIST_PRICE) < 500