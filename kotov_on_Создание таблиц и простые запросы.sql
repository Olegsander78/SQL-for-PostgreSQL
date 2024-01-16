--DATABASE sqlfree
--����� kotov_on

 --   ����� ���������� �������� ���� ���������?
SELECT COUNT(order_id) 
FROM orders  
--9465

 --   ����� ���������� ������� ��������� � ��������� ��������?
SELECT SUM(p.remains) 
FROM category c 
JOIN product p ON c.category_id = p.category_id
WHERE c.category = '�������'

SELECT SUM(p.remains) 
FROM category c, product p   
WHERE c.category_id = p.category_id AND c.category = '�������'
--998

 --   � ����� ��������� ��������� ������ ����� �������?
SELECT c.category_id, c.category, SUM(p.remains) AS sum_cat
FROM category c
JOIN product p ON c.category_id = p.category_id
GROUP BY c.category_id, c.category
ORDER BY sum_cat DESC
LIMIT 1;
--83	������	64000.00

 --   ������� ��������� ������ Williams Linda?
SELECT c.last_name, c.first_name, p.product , SUM(opl.amount)
FROM customer c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_product_list opl ON o.order_id = opl.order_id 
JOIN product p ON opl.product_id = p.product_id 
WHERE (c.last_name = 'Williams' AND c.first_name = 'Linda') AND p.product = '��������'
GROUP BY c.last_name, c.first_name, p.product
--Williams	Linda	��������	3.00
