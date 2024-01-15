--DATABASE sqlfree
--Схема kotov_on

 --   Какое количество платежей было совершено?
select count(order_id) 
from orders  
--9465

 --   Какое количество товаров находится в категории «Игрушки»?
select sum(p.remains) 
from category c 
join product p on c.category_id = p.category_id
where c.category = 'Игрушки'

select sum(p.remains) 
from category c, product p   
where c.category_id = p.category_id and c.category = 'Игрушки'
--998

 --   В какой категории находится больше всего товаров?
SELECT c.category_id, c.category, sum(p.remains) as sum_cat
FROM category c
JOIN product p ON c.category_id = p.category_id
GROUP BY c.category_id, c.category
ORDER BY sum_cat DESC
LIMIT 1;
--83	Музыка	64000.00

 --   Сколько «Черепах» купила Williams Linda?
select c.last_name, c.first_name, p.product , sum(opl.amount)
from customer c
join orders o on c.customer_id = o.customer_id
join order_product_list opl on o.order_id = opl.order_id 
join product p on opl.product_id = p.product_id 
where (c.last_name = 'Williams' and c.first_name = 'Linda') and p.product = 'Черепаха'
group by c.last_name, c.first_name, p.product
--Williams	Linda	Черепаха	3.00
