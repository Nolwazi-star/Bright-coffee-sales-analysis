SELECT *
  FROM
  sales.bright_coffee;

----------------------------------------------------------------------------------------------------------
SELECT
  transaction_date,
  DAYNAME(transaction_date) AS day_name,
  CASE
    WHEN day_name IN ('Sun', 'Sat') THEN 'weekend'
    ELSE 'weekday'
  END AS Day_classification,
  MONTHNAME(transaction_date) AS month_name,

DATE_FORMAT(transaction_time, 'HH:mm:ss')AS transaction_time_only,
  CASE
    WHEN transaction_time_only BETWEEN '06:00:00' AND '11:59:59' THEN 'morning'
    WHEN transaction_time_only BETWEEN '12:00:00' AND '16:59:59' THEN 'afternoon'
    WHEN transaction_time_only >= '17:00:00' THEN ' evening'
  END AS time_classification,

  store_location,
  product_category,
  product_type,
  product_detail,
  COUNT(transaction_id)AS number_of_sales, 

  SUM(transaction_qty*unit_price)AS Revenue
FROM
  sales.bright_coffee
  GROUP BY store_location,
           product_category,
           product_type,
           product_detail,
           transaction_date,
            DAYNAME(transaction_date),
            MONTHNAME(transaction_date),
            DATE_FORMAT(transaction_time, 'HH:mm:ss');
