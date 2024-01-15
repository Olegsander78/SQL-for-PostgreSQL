--DATABASE sqlfree
--����� kotov_on

 --   ����� ���������� �������� ���� ���������?
select count(order_id) 
from orders  
--9465

 --   ����� ���������� ������� ��������� � ��������� ��������?
select sum(p.remains) 
from category c 
join product p on c.category_id = p.category_id
where c.category = '�������'

select sum(p.remains) 
from category c, product p   
where c.category_id = p.category_id and c.category = '�������'
--998

 --   � ����� ��������� ��������� ������ ����� �������?
SELECT c.category_id, c.category, sum(p.remains) as sum_cat
FROM category c
JOIN product p ON c.category_id = p.category_id
GROUP BY c.category_id, c.category
ORDER BY sum_cat DESC
LIMIT 1;
--83	������	64000.00

 --   ������� ��������� ������ Williams Linda?
select c.last_name, c.first_name, p.product , sum(opl.amount)
from customer c
join orders o on c.customer_id = o.customer_id
join order_product_list opl on o.order_id = opl.order_id 
join product p on opl.product_id = p.product_id 
where (c.last_name = 'Williams' and c.first_name = 'Linda') and p.product = '��������'
group by c.last_name, c.first_name, p.product
--Williams	Linda	��������	3.00
