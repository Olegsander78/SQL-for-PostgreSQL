--ОКОННЫЕ ФУНКЦИИ И ПОДЗАПРОСЫ
SELECT order_id, customer_id, amount,
	ROW_NUMBER() OVER (PARTITION BY 
	customer_id ORDER BY amount)
FROM orders o 
OFFSET 25

--Отношение стоимости товаров к единице стоимости этих товаров
SELECT DISTINCT opl.product_id , SUM(o.amount) OVER (PARTITION BY p.product_id) / price
FROM orders o 
JOIN order_product_list opl ON o.order_id  = opl.order_id 
JOIN product p ON p.product_id = opl.product_id 

--Получим данные о каждом 1000 заказе
SELECT *
FROM (
SELECT order_id , customer_id , amount ,
	row_number () OVER (ORDER BY order_id)
FROM orders o ) t
WHERE t.row_number % 1000 = 0

--Получить накопительную сумму платежей по каждому пользователю
SELECT order_id , customer_id , amount ,
	sum(amount) OVER (PARTITION BY customer_id ORDER BY order_id) 
FROM orders o 

--Категория товара с наибольшим процентным отношение количества товаров от общего количества товаров.
--Какова процентная доля у этой категории? 
SELECT DISTINCT c.category_id , SUM(p.remains) OVER (PARTITION BY c.category_id) /  (SELECT SUM(p2.remains) FROM product p2) t
FROM category c 
JOIN product p ON p.category_id  = c.category_id  
ORDER BY t DESC
LIMIT 1

-- ПРЕДСТАВЛЕНИЯ

--нужно постоянно получать данные по последнему заказу пользователя
CREATE VIEW task_1 AS
SELECT *
FROM (
SELECT order_id , customer_id , amount ,
	row_number () OVER (PARTITION BY customer_id ORDER BY order_id DESC)
FROM orders o ) t
WHERE row_number  = 1

SELECT * FROM task_1 t 

--то же с материализованным представлением
CREATE MATERIALIZED VIEW task_2 AS
SELECT *
FROM (
SELECT order_id , customer_id , amount ,
	row_number () OVER (PARTITION BY customer_id ORDER BY order_id DESC)
FROM orders o ) t
WHERE row_number  = 1
WITH NO DATA 

--обновление данных в материализованном представлении
REFRESH MATERIALIZED VIEW task_2 

SELECT * FROM task_2 t 

--удаление материализованного представления
DROP MATERIALIZED VIEW task_2 