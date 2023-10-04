select * from [dbo].[sales_data_sample]

--CHecking unique values
select distinct status from [dbo].[sales_data_sample] --
select distinct PRODUCTLINE from [dbo].[sales_data_sample] --
select distinct COUNTRY from [dbo].[sales_data_sample] ---
select distinct DEALSIZE from [dbo].[sales_data_sample] 
select distinct TERRITORY from [dbo].[sales_data_sample] 

select distinct MONTH_ID from [dbo].[sales_data_sample]
where year_id = 2003

---ANALYSIS
----Let's start by grouping sales by productline
select PRODUCTLINE, sum(sales) Revenue
from [dbo].[sales_data_sample]
group by PRODUCTLINE
order by 2 desc


select YEAR_ID, sum(sales) Revenue
from [dbo].[sales_data_sample]
group by YEAR_ID
order by 2 desc

select  DEALSIZE,  sum(sales) Revenue
from [dbo].[sales_data_sample]
group by  DEALSIZE
order by 2 desc


----What was the best month for sales in a specific year? How much was earned that month? 
select  MONTH_ID, sum(sales) Revenue, count(ORDERNUMBER) Frequency
from [dbo].[sales_data_sample]
where YEAR_ID = 2004 -
group by  MONTH_ID
order by 2 desc


--November seems to be the month, what product do they sell in November
select  MONTH_ID, PRODUCTLINE, sum(sales) Revenue, count(ORDERNUMBER)
from [dbo].[sales_data_sample]
where YEAR_ID = 2004 and MONTH_ID = 11
group by  MONTH_ID, PRODUCTLINE
order by 3 desc
	
---best customer----
select 
		CUSTOMERNAME, 
		sum(sales) MonetaryValue,
		avg(sales) AvgMonetaryValue,
		count(ORDERNUMBER) Frequency,
		max(ORDERDATE) last_order_date,
		(select max(ORDERDATE) from [dbo].[sales_data_sample]) max_order_date,
		DATEDIFF(DD, max(ORDERDATE), (select max(ORDERDATE) from [dbo].[sales_data_sample])) Recency
	from [dbo].[sales_data_sample]
	group by CUSTOMERNAME


---What is the best product in france?
select country, YEAR_ID, PRODUCTLINE, sum(sales) Revenue
from [dbo].[sales_data_sample]
where country = 'France'
group by  country, YEAR_ID, PRODUCTLINE
order by 4 desc

--What city has the highest number of sales in a specific country
select city, sum (sales) Revenue
from [dbo].[sales_data_sample]
where country = 'UK'
group by city
order by 2 desc
