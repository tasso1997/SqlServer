---------QUESTION 1--------
CREATE VIEW SALES_INFO 
AS
SELECT production.products.product_id,product_name,production.products.list_price FROM sales.order_items INNER JOIN sales.orders
ON sales.order_items.order_id = sales.orders.order_id INNER JOIN production.products 
ON sales.order_items.product_id = production.products.product_id

SELECT * FROM SALES_INFO

------------QUESTION 2----------
ALTER VIEW STAFF_SALES
AS
SELECT S.FIRST_NAME,S.LAST_NAME,SUM(QUANTITY * list_price) AS 'ORDER VALUE' FROM SALES.orders O INNER JOIN SALES.staffs S 
ON O.staff_id=S.staff_id 
INNER JOIN
SALES.order_items OI
ON OI.order_id=O.order_id
GROUP BY  
 FIRST_NAME,LAST_NAME

 SELECT * FROM STAFF_SALES


 ---------QUESTION 3----------
 ALTER PROCEDURE USP_ADD_STORE
 @STORE_NAME VARCHAR(255),
 @PHONE VARCHAR(25),
 @EMAIL VARCHAR(255),
 @STORE_COUNT INT OUTPUT
 AS
 BEGIN
	INSERT INTO SALES.stores(store_name,phone,email) VALUES( @STORE_NAME, @PHONE,@EMAIL) 
	SELECT  @STORE_COUNT=COUNT(STORE_ID) FROM SALES.stores 
 END

 -----------CALLING SP-----------
 DECLARE @COUNT INT;
 EXEC USP_ADD_STORE
 @STORE_NAME ='TASLIM',
 @PHONE ='234567',
 @EMAIL ='ABC.COM',
 @STORE_COUNT =@COUNT OUTPUT
 SELECT  @COUNT AS 'STORE COUNT'

 ----------DISPLAY STORE INFO----------
 SELECT * FROM SALES.stores


 ------------QUESTION 4--------------
 CREATE PROCEDURE USP_STORE_WISE_SALES
 AS
 BEGIN
	SELECT S.STORE_ID,S.STORE_NAME,S.CITY,COUNT(O.ORDER_ID) AS 'ORDER COUNT'
	FROM sales.orders O INNER JOIN sales.stores S
	ON O.store_id=S.store_id
	GROUP BY S.STORE_ID,S.STORE_NAME,S.CITY
	ORDER BY S.store_id
 END

 EXEC USP_STORE_WISE_SALES

 -----------QUESTION 5----------------
 CREATE FUNCTION AVG_QUANTITY
 (
 @customer_id int,
 @year int)
 RETURNS int
 AS
 BEGIN
	declare @order_count INT
	select @order_count=sum(quantity * list_price)
	from sales.order_items oi
	inner join
	sales.orders o
	on oi.order_id=o.order_id
	where customer_id=@customer_id and year(order_date)=@year
	return @order_count
 END;

 select dbo.AVG_QUANTITY(5,2016) AS 'ORDER COUNT'
