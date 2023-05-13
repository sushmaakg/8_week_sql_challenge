/* --------------------
   Case Study Questions
   --------------------*/

-- 1. What is the total amount each customer spent at the restaurant?

SELECT
  	s.customer_id,sum(m.price)
FROM dannys_diner.sales s
inner join dannys_diner.menu m 
on s.product_id=m.product_id
group by s.customer_id
;

-- 2. How many days has each customer visited the restaurant?
SELECT
  	s.customer_id,count(s.order_date)
FROM dannys_diner.members m
left join dannys_diner.sales s 
on s.customer_id=m.customer_id
group by s.customer_id
;

-- 3. What was the first item from the menu purchased by each customer?
/*This question is slighty ambigious, if a customer orders more than one item from menu on same date which one will be considered as first? I have considered the product_id as one of the consideration in case of tie*/
select s.customer_id,m.product_name 
from dannys_diner.sales s 
inner join dannys_diner.menu m 
on s.product_id=m.product_id
where (order_date,s.product_id)=(select min(order_date),min(product_id) from dannys_diner.sales s1 where s1.customer_id=s.customer_id);

-- 4. What is the most purchased item on the menu and how many times was it purchased by all customers?
SELECT PRODUCT_ID,COUNT(*) CNT FROM dannys_diner.SALES GROUP BY PRODUCT_ID ORDER BY CNT DESC LIMIT 1;



-- 5. Which item was the most popular for each customer?
/*This question is slighty ambigious, there could be tie in that case I am resulting all*/
select customer_id,product_id from (
select customer_id,product_id,cnt,dense_rank() over(partition by customer_id order by cnt desc) as rnk 
from (
select customer_id,product_id,count(*) cnt
from dannys_diner.sales group by customer_id,product_id) a
) a where rnk=1

-- 6. Which item was purchased first by the customer after they became a member?
-- 7. Which item was purchased just before the customer became a member?
-- 8. What is the total items and amount spent for each member before they became a member?
-- 9.  If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?
-- 10. In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi - how many points do customer A and B have at the end of January?
