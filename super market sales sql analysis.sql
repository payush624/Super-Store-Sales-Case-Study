create database Superstore;
use Superstore;
Select * from Superstore_sales; 

-- States in which Superstore is present
select Distinct(State) from Superstore_sales;

-- Store present in different cites of each State
select State,city from Superstore_sales group by state,city;

-- Number of Stores in each region
select region,count(region) as No_of_Stores from Superstore_sales group by region;

-- Categories and sub categories in store
select distinct(Category),`Sub-Category` from Superstore_sales group by Category,`Sub-Category`;

-- MOst purchased category
select distinct(`Category`),count(`Category`) from Superstore_sales group by `Category`;

-- MOst purchased subcategory
select distinct(`Sub-Category`),count(`Sub-Category`) from Superstore_sales group by `Sub-Category`;


-- MOst purchased Product
select distinct(Product_Name),count(Product_Name) as No_of_Times_bought from Superstore_sales
group by Product_Name 
Order by count(Product_Name) desc ;





--  Create Temporary Table to get information about sales the main motive of temp table was to remove unwanted columns and row
create TEMPORARY TABLE Sales_insights (select Customer_ID,Customer_Name,substr(Order_Date,7,10) as Order_Date,Country,State,Region,Category,`Sub-Category`,Sales from Superstore_sales);
select * from Sales_insights;

--                            SALES 

-- sales in state for each year
select state,Order_Date,Round(sum(Sales),2) from Sales_insights 
group by state,Order_Date;

-- sales by category
select distinct(category),Round(sum(sales),2) as Total_Sales from Sales_insights
group by category 
order by sum(sales) desc; 

--  sales by sub category
select distinct(`Sub-Category`),Round(sum(sales),2) as Total_Sales from Sales_insights 
group by `Sub-Category` 
order by sum(sales) desc; 

-- avg sales per region
select distinct(region),Round(sum(sales)) as Total_Sales from Sales_insights
group by region
order by sum(sales) desc; 

-- sales by year  STORED PROCEDURE

select distinct(Order_Date), Round(sum(sales),2) as Total_sales from Sales_insights
group by Order_Date;

 --                       USER
 
 -- which user has spent more in shpping
select distinct(Customer_Name),Round(sum(sales),2) from Superstore_sales
group by Customer_Name
order by sum(sales) desc
limit 10;
 
-- Day to ship
select Customer_id,Customer_Name,State,City,abs(substr(Ship__Date,1,2)-substr(Order_Date,1,2)) as Order_delivery_days from Superstore_sales
order by Customer_Name;

-- how active customer is 	
select Customer_Name, count(Order_ID) as Total_Order,
case 
when count(Order_ID) >= 20 then 'Active Customer'
when count(Order_ID) >= 5 and count(Order_ID) <=19 then 'Potential Customer'
when count(Order_ID) <= 4 then 'Recent Customer'
End AS Type_of_Customer
from Superstore_sales group by  Customer_Name order by count(Order_ID) desc;





