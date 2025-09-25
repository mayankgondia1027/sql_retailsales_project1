create database retailsales;
use retailsales;
select * from sales;
DESCRIBE sales;

-- count
select count(customer_id) as Total_Customers from sales ;

-- unique id
select count(distinct customer_id) as Total_Customers from sales ;

-- unique category
select count(distinct category) from sales ;

-- category names
select distinct category from sales ;

-- check null values
select * from sales
where 
     ï»¿transactions_id is null
     or sale_date is null
     or sale_time is null
     or customer_id is null
     or gender is null
     or age is null
     or category is null
     or quantiy is null
	 or price_per_unit is null
     or cogs is null
     or total_sale is null;
 
 -- deleteing null rows if exists
delete from sales
where 
     ï»¿transactions_id is null
     or sale_date is null
     or sale_time is null
     or customer_id is null
     or gender is null
     or age is null
     or category is null
     or quantiy is null
	 or price_per_unit is null
     or cogs is null
     or total_sale is null;
     
select sum(total_sales) from sales;

-- retrive all columns for sales on 2022-11-05
select * from sales 
where sale_date = "05-11-2022";

-- retrive all transactions where the category is clothing and the quantity sold is more than 1
-- in the month of nov 2022
SELECT *
FROM sales
WHERE category = 'Clothing'
  AND quantiy >= 1
  AND sale_date >= '01-11-2022'
  AND sale_date <= '31-11-2022';
  
-- calculate the total sales for each category 
select category, sum(total_sale) as total_sales,count(*) as total_orders
from sales
group by category
order by total_sales desc;

-- avg age of customers who purchased items from the beauty category
select round(avg(age),0) as average_age from sales
where category="Beauty";

-- find all the transactions where totalsale is greater than 1000
select * from sales
where total_sale>=1000
order by total_sale asc;

-- find total number of transactions made by each gender in each category
select  category,gender,count(*) from sales
group by gender, category
order by category;

-- cal the avg sale for each month find out the best selling month in each year
select * from
(
   select extract(year from sale_date),
   extract(month from sale_date),
   avg(total_sale),
   rank() over(partition by extract(year from sale_date) order by avg(total_sale) desc) as rnk
   from sales
   group by extract(year from sale_date),extract(month from sale_date)
   ) as T1
where rnk = 1;  
  
-- find the top 5 customers based on highest total sales
select customer_id, sum(total_sale)from sales
group by customer_id
order by sum(total_sale) desc limit 5;

-- find the number of unique customers who purchased items from each category
select category, count(distinct(customer_id)) from sales
group by category;

-- create each shift and number of orders eg morning<=12 afternoon b/w 12&17 evening>17
with hourly_sale
as
(
select *,
     case
         when extract(hour from sale_time)<12 then "morning"
		 when extract(hour from sale_time) between 12 and 17 then "afternoon"
         else "evening"
       end as shift  
from sales
)
select shift, count(*) as total_orders
from hourly_sale
group by shift;






