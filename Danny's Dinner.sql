-- 1. What is the total amount each customer spent at the restaurant

SELECT
  	s.customer_id,sum(m.price)
FROM dannys_diner.sales s
inner join dannys_diner.menu m 
on s.product_id=m.product_id
group by s.customer_id
;
