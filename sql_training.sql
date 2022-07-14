USE sales_data;

drop table if exists tableau_dashboards.sales_customer_agent;

SELECT
sales_fact.Order_id
,sales_fact.Customer_id
,Customer_FirstName
,Customer_LastName
,Product
,Sale_office
,sales_fact.Agent_Id
,Agent_Name
,COALESCE(Agent_Active, 'Online Sale') AS Agent_active
into tableau_dashboards.sales_customer_agent
FROM sales_fact a join customer_dim b on a.Customer_Id = b.Customer_Id
join product_dim c on a.Product_Id = c.Product_Id
join (
    SELECT
    Region_id
    , Sales_office
    FROM
    (SELECT
    Region_id,
    MAX(Start_date_office) as start_date
    FROM
    Sales_office_data
    GROUP BY Region_id) d JOIN Sales_office_data e ON d.Region_id = e.Region_id AND  d.start_date = e.Start_date
    ) f on a.Region_id = f.Region_id 
join Agent_data g on sales_fact.Agent_Id = g.agent_id
;



/* Base of table */
drop table if exists #sales_fact;

SELECT
      Order_id
    , Customer_id
    , Product_id
    , Region_id
    , agent_id
INTO #sales_fact
FROM sales_fact;

-- SELECT COUNT(*) AS row_cnt, 
-- COUNT( DISTINCT Order_id) AS dst_order_cnt
-- FROM #sales_fact

/* Sales Office Data */




/* Bring all together */

-- QA count, compare with initial
-- Add join by join and repeat count