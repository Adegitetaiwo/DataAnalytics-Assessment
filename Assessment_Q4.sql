
-- Customer Lifetime Value (CLV) Estimation

WITH user_tenure AS (
-- Get the customers id and their tenure months 
SELECT 
    user.id AS customer_id,  
    CONCAT(user.first_name, ' ', user.last_name) AS name,
    date_joined,
    ROUND(TIMESTAMPDIFF(MONTH, date_joined, CURRENT_DATE()), 0) AS tenure_months -- Approximate the number of months into whole numbers
FROM adashi_staging.users_customuser AS user
),

user_trasaction_statistics AS (
-- Get the profit per transaction and total number of Transaction per user
SELECT 
	transactions.owner_id AS customer_id,
    COUNT(*) AS total_transaction,
    AVG(transactions.confirmed_amount * 0.001) AS avg_profit_per_transaction 
FROM savings_savingsaccount AS transactions
WHERE transactions.confirmed_amount IS NOT NULL -- just incase, remove any transaction with NULL value
GROUP BY transactions.owner_id
)

-- Making sure i account for users who does not have any transaction, using COALESCE to give them 0 value after joining with user table
SELECT 
	user_tenure.customer_id,
    user_tenure.name,
    user_tenure.tenure_months,
    COALESCE(transaction_stat.total_transaction, 0) AS total_transactions,
    ROUND((COALESCE(transaction_stat.total_transaction, 0) / NULLIF(user_tenure.tenure_months, 0)) * 12 * COALESCE(transaction_stat.avg_profit_per_transaction, 0), 2) AS estimated_clv
FROM user_tenure
LEFT JOIN user_trasaction_statistics AS transaction_stat
ON user_tenure.customer_id = transaction_stat.customer_id
ORDER BY estimated_clv DESC;