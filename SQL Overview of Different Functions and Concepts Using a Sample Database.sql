--Sample Database Inserted from: https://www.dofactory.com/sql/sample-database
--Project Created by Dan Harig 7/12/2023



/*CTE With Statement to compare total price per id by average price*/

with Total_UnitPrice (supplierid, total_price_per_ID) as

	(Select p.supplierid, sum(unitprice) as total_price_per_ID
	from Product p
	group by p.SupplierId),

	avg_price (avg_price_per_ID) as
	(select cast(avg(total_price_per_ID) as INT) as avg_price_per_ID
	from Total_UnitPrice)


select *

from Total_UnitPrice tp
join avg_price ap
on tp.total_price_per_ID > ap.avg_price_per_ID

/* Union Example, without Union All it removes the duplicates between the tables*/

select Id, City, Country, Phone from Supplier as S
Union 
Select Id, City, Country, Phone from Customer as C



/*Aggregating Revenue of Orders By Year*/


select YEAR(ORDERDATE) 'Year', cast(SUM(totalAmount) as float) AS Totals_By_Year

from [master].[dbo].[Order]

group by YEAR(OrderDate)
order by Year

/* Q1 Results for 2014*/

select cast(SUM(totalAmount) as int), OrderDate AS Totals_Q1

from [master].[dbo].[Order]

where OrderDate between '2014-01-01' and '2014-03-30'

group by OrderDate

/*Validation of first two rows*/

select (totalAmount) TotalsQ1, OrderDate AS Date

from [master].[dbo].[Order]

where OrderDate between '2014-01-01' and '2014-01-02'

group by OrderDate, TotalAmount

/*RANK Windows Function*/

Select SupplierId, UnitPrice, ProductName,

RANK() OVER (Partition by SupplierID Order BY UnitPrice) Rank

from Product

Order By SupplierID, Rank;

/* Checking the Min Totals for 2012 with Raw Data below for validation */

select month(ORDERDATE) 'month', cast(min(totalAmount) as float) AS Totals_By_Year

from [master].[dbo].[Order]

where OrderDate like '%2012%'

group by month(OrderDate)

order by month

/* Raw Data */

select * from [master].[dbo].[Order]

where OrderDate like '%2012%' 

order by TotalAmount asc


/*All Tables in Sample Database*/


Select * from Customer
Select * from Product
select * from Supplier
select * from OrderItem
select * from [master].[dbo].[Order]