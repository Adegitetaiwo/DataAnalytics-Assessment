
-- Transaction Frequency Analysis
-- Break down the logics into virtual tables
-- Kindly make sure the database has been selected
-- Get the list of customer and the number of trasaction the have made per month every year
-- Turn it into a virtual table
WITH customer_monthly_transaction_frequency AS (
SELECT 
	customer.id AS user_id, 
    YEAR(deposit.transaction_date) AS year, 
    MONTH(deposit.transaction_date) AS month, 
    COALESCE(COUNT(deposit.confirmed_amount),0) AS saving_count
FROM users_customuser AS customer
LEFT JOIN savings_savingsaccount AS deposit
ON customer.id = deposit.owner_id

-- don't count transaction that did not come through
WHERE deposit.confirmed_amount IS NOT NULL
GROUP BY 
	customer.id,
    year,
    month
),

users_average_transaction_per_month AS (
-- Now use that virtual table to get the monthly average
SELECT 
	user_id, 
    AVG(COALESCE(customer_monthly_transaction_frequency.saving_count,0)) AS avg_transactions_per_month
FROM customer_monthly_transaction_frequency
GROUP BY user_id
),

categorized_user AS (
-- Give each customer who meet the above criteria a label
-- IF their monthly average transaction is greater or equal to 10 give them 'High Frequency'
-- ELSE IF their monthly average transaction is between 3 and 9 give them 'Medium Frequency'
-- ELSE IF their monthly average transaction is less than or equal to 2 give them 'Low Frequency'
SELECT 
	user_id,
    CASE 
		-- Some users avg transaction are bewteen the provided range, so it best to round them to whole number or choose a range that consider decimal numbers
		WHEN ROUND(COALESCE(avg_transactions_per_month, 0),0) >= 10 THEN 'High Frequency'
        WHEN ROUND(COALESCE(avg_transactions_per_month, 0),0) BETWEEN 3 AND 9 THEN 'Medium Frequency'
        WHEN ROUND(COALESCE(avg_transactions_per_month, 0),0) <= 2 THEN 'Low Frequency'
	END AS frequency_category,
    avg_transactions_per_month
FROM users_average_transaction_per_month AS user_avg
GROUP BY user_id
)

SELECT 
	frequency_category,
    COUNT(user_id) AS customer_count,
    AVG(avg_transactions_per_month) AS avg_transactions_per_month
FROM categorized_user
GROUP BY frequency_category;