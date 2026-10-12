USE ANJALIDB;
SELECT * FROM ORDERS LIMIT 5;
SELECT * FROM PRODUCT LIMIT 5;
SELECT * FROM ORDERDETAILS LIMIT 5;
SELECT * FROM CUSTOMERS LIMIT 5;

-- QUESTION_1
DESCRIBE Customers;
DESCRIBE products;
DESCRIBE Orders;
DESCRIBE OrderDetails;

-- QUESTION_2
select location,count(ï»¿customer_id) as number_of_customers from customers
group by location
order by number_of_customers desc limit 3;

-- a) Delhi, Chennai, Jaipur

-- QUESTION_3
select NumberOfOrders, count(*) as CustomerCount from (
select customer_id, count(*) as NumberOFOrders from orders
group by customer_id) as Customer_orders
group by NumberOfOrders
order by NumberOfOrders asc;

-- a) As the number of orders increses,the customer counts decreses.
-- b) Occasional Shopper

-- Question_4
select Product_id, Avg(Quantity) as AvgQuantity, sum(quantity * price_per_unit) as TotalRevenue from orderdetails
group by product_id
HAVING Avg(Quantity) = 2
order by TotalRevenue desc;

-- a) Product 1

-- QUESTION_5
select p.category, count(distinct o.customer_id)
as unique_customers from product p 
join orderdetails od on p.ï»¿product_id = od.product_id
join orders o on od.ï»¿order_id = o.ï»¿order_id
group by p.category
order by unique_customers desc;

-- a) ELECTRONICS 

-- QUESTION_6
select Month, TotalSales, round((totalsales - PreviousMonthSales) / PreviousMonthSales * 100, 2) 
as PercentChange from ( select date_format(order_date, '%Y-%m') as Month, sum(total_amount) as TotalSales, 
lag(sum(total_amount)) over(order by date_format(order_date, '%Y-%m')) as PreviousMonthSales
from Orders 
group by date_format(order_date, '%Y-%m')) as monthly_sales;

-- a) Feb 2024
-- b) Sales Fluctuated with no clear trend. 

-- QUESTION_7
select Month, AvgOrderValue, round(AvgOrderValue - lag(AvgOrderValue) over(order by Month), 2)
 as ChangeInValue from (
 select date_format(order_date, '%Y-%m') as Month, round(avg(total_amount), 2) as AvgOrderValue
 from Orders
 group by date_format(order_date, '%Y-%m')) as monthly
 order by ChangeInValue desc;
 
 -- a) December 
 
 -- QUESTION_8
 select product_id, sum(quantity * price_per_unit) as SalesFrequency from orderdetails
 group by product_id 
 order by SalesFrequency desc limit 5;
 
 -- a) 7
 
 -- QUESTION_9
 select p.ï»¿product_id as Product_id,p.Name,
count(DISTINCT o.ï»¿customer_id) as UniqueCustomerCount
from Product
join orderdetails od  
on p.ï»¿product_id = od.product_id
group by p.ï»¿product_id, p.name
having count(distinct o.customer_id) < (select count(*) * 0.40
from customers
)
order by p.product_id;

-- a) Poor Visibility on the Platform.
-- b) Implemented targeted marketing campaigns to raise awareness and interest.

-- QUESTION_10
select FirstPurchaseMonth, count(*) as TotalNewCustomers from (
select customer_id, date_format(min(order_date), '%Y-%m') as FirstPurchaseMonth from orders 
group by customer_id) as first_purchase
group by FirstPurchaseMonth
order by FirstPurchaseMonth asc;

-- a) It is downward trend which implies the marketing campaign are not much effective. 

-- QUESTION_11 
select date_format(order_date, '%Y-%m') as Month, sum(total_amount) as TotalSales from orders
group by date_format(order_date, '%Y-%m')
order by TotalSales desc limit 3;

-- a) September, December 



 