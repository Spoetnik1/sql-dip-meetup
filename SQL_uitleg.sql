USE sales_data;

SELECT
sales_fact.Order_id
,sales_fact.Customer_id
,Customer_FirstName
,Customer_LastName
,Product
,Sale_office
,Agent_sales_fact.Agent_Id
,Agent_Name
,COALESCE(Agent_Active, 'Online Sale') AS Agent_active
FROM sales_fact a join customer_dim b on a.Customer_Id = b.Customer_Id
join product_dim c on a.Product_Id = c.Product_Id
join (
SELECT
Region_id
, Sales_office
FROM
(SELECT
Region_id,
MAX(Start_date) as start_date
FROM
Sales_office_data
GROUP BY Region_id) d JOIN Sales_office_data e ON d.Region_id = e.Region_id AND  d.start_date = e.Start_date
) f on a.Region_id = f.Region_id 
join 


