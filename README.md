# :question: Superstore Sales Case Study

## 📌 Findings

### 1. In how many cities does store deliver
````sql
select count(distinct State) from Superstore_sales;
````
<img width="141" alt="image" src="https://github.com/payush624/Super-Store-Sales-Case-Study/blob/main/q1">

The Store delivers to 48 differnt states in USA

### 2. No of Delivery in Each Region
````sql
select region,count(region) as No_of_Delivery from Superstore_sales 
group by region
order by count(region) desc;
````
<img width="141" alt="image" src="https://github.com/payush624/Super-Store-Sales-Case-Study/blob/main/q2">

West region deliverd more products ie 3038 and south region delivered less ie 1557

### 3. Categories and Sub Categories in store
````sql
select distinct(Category),`Sub-Category` from Superstore_sales group by Category,`Sub-Category`;
````
<img width="141" alt="image" src="https://github.com/payush624/Super-Store-Sales-Case-Study/blob/main/q3">

There are 3 main Category and multiple sub category

### 4. Most Purchased Category
````sql
select distinct(`Category`),count(`Category`) as Total_count from Superstore_sales group by `Category` 
order by Total_count desc;
````
<img width="141" alt="image" src="https://github.com/payush624/Super-Store-Sales-Case-Study/blob/main/q4">

Most Purchased Category is Office Supplies and least Purchased Category is Technology

### 5. Most Purchased Product
````sql
select distinct(Product_Name),count(Product_Name) as No_of_Times_bought from Superstore_sales
group by Product_Name 
Order by count(Product_Name) desc
limit 50 ;
````
<img width="180" alt="image" src="https://github.com/payush624/Super-Store-Sales-Case-Study/blob/main/q5">

### Creating Temporary Table to get information about sales, the main motive of temporary table was to remove unwanted columns and make table easy to analyse 
````sql 
create TEMPORARY TABLE Sales_insights (select Customer_ID,Customer_Name,substr(Order_Date,7,10) as Order_Date,Country,State,Region,Category,`Sub-Category`,Sales from Superstore_sales);
select * from Sales_insights;
````

### 6. Sales in each State by year
````sql
select state,Order_Date,Round(sum(Sales),2) as Sales from Sales_insights 
group by state,Order_Date;

````
<img width="141" alt="image" src="https://github.com/payush624/Super-Store-Sales-Case-Study/blob/main/q6">



### 7. Sales by Sub-Category
````sql

select distinct(`Sub-Category`),Round(sum(sales),2) as Total_Sales from Sales_insights 
group by `Sub-Category` 
order by sum(sales) desc; 
````
<img width="141" alt="image" src="https://github.com/payush624/Super-Store-Sales-Case-Study/blob/main/q7">



### 8. No of Days to ship each Product
````sql 
select Customer_id,Customer_Name,State,City,abs(substr(Ship__Date,1,2)-substr(Order_Date,1,2)) as Order_delivery_days from Superstore_sales
order by Customer_Name;
````
<img width="141" alt="image" src="https://github.com/payush624/Super-Store-Sales-Case-Study/blob/main/q8">


### 9. Creating Stored Procedure for Sales by Year (Stored Procedure is created so that we don't have to write query each time when data gets updated)
````sql 
 Delimiter $$
 create procedure BY_year ()
 Begin
 select substr(Order_Date,7,10) as Year,Round(sum(sales),2) as Total_Sales from Superstore_sales
 group by substr(Order_Date,7,10);
 End $$
 Delimiter ;
 call By_year() ;
````
<img width="141" alt="image" src="https://github.com/payush624/Super-Store-Sales-Case-Study/blob/main/q9">


### 10. Most Preferred method for delivery 
````sql 
select distinct(Ship_Mode), count(Ship_Mode) as Count_of_Ship_Mode from Superstore_sales
group by Ship_Mode
order by count(Ship_Mode) desc;
````
<img width="141" alt="image" src="https://github.com/payush624/Super-Store-Sales-Case-Study/blob/main/q10">

Standard Class is most Preferred mode for delivery

create TEMPORARY TABLE Profit(
select Region,substr(Order_Date,7,10) as Year,Round(sum(Sales)) as Sales_Made from Superstore_sales
group by Region,substr(Order_Date,7,10)
order by Round(sum(Sales)));

select * from Profit;

### 11. Total Sales by Region (Performance based on Region)
````sql
select Distinct(Region),sum(Sales_Made) as Total_Sales_over_Years from Profit
group by Region
order by sum(Sales_Made) Desc;
````
<img width="141" alt="image" src="https://github.com/payush624/Super-Store-Sales-Case-Study/blob/main/q11">


### 12. Lowest to Highest sales by Region and Year
````sql 
select Region,substr(Order_Date,7,10) as Year,Round(sum(Sales)) as Sales_Made from Superstore_sales
group by Region,substr(Order_Date,7,10)
order by Round(sum(Sales));
````
<img width="141" alt="image" src="https://github.com/payush624/Super-Store-Sales-Case-Study/blob/main/q12">


### 13. Categorizing Customer's based on their Total Purchase
````sql  	
select Customer_Name, count(Order_ID) as Total_Order,
case 
when count(Order_ID) >= 20 then 'Potential Customer'
when count(Order_ID) >= 5 and count(Order_ID) <=19 then 'Active Customer'
when count(Order_ID) <= 4 then 'Recent Customer'
End AS Type_of_Customer
from Superstore_sales group by  Customer_Name order by count(Order_ID) desc;

````
<img width="141" alt="image" src="https://github.com/payush624/Super-Store-Sales-Case-Study/blob/main/q13">

<img width="141" alt="image" src="https://github.com/payush624/Super-Store-Sales-Case-Study/blob/main/q13b">
