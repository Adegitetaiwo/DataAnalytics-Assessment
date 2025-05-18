
-- Account Inactivity Alert
-- Break down the logics into virtual tables
-- Kindly make sure the database has been selected

WITH last_transactions_on_plan AS (

-- Find the active account and their last date of transaction
SELECT 
	plan.id AS plan_id, 
    plan.owner_id AS owner_id,
	CASE 
		WHEN plan.is_a_fund=1 THEN "Investment"
        WHEN plan.is_regular_savings=1 THEN "Savings"
	END AS type, -- create a column that shows if a plan is a Savings or Investment plan
    MAX(transactions.transaction_date) AS last_transaction_date -- Get the last transaction date
FROM savings_savingsaccount AS transactions
LEFT JOIN plans_plan AS plan
ON transactions.plan_id = plan.id
WHERE plan.is_a_fund = 1
OR plan.is_regular_savings = 1
GROUP BY plan_id
 )
 
 -- Use the virtual table 'last_transactions_on_plan' and
 -- Filter for plan whose day diiference between last_transaction and current date is > 365
 SELECT 
	plan_id,
	owner_id, 
    type, 
    last_transaction_date, 
    DATEDIFF(CURRENT_DATE(), last_transaction_date) AS inactivity_days -- Find the day diiference between today's date and last transaction date
 FROM last_transactions_on_plan
 WHERE DATEDIFF(CURRENT_DATE(), last_transaction_date) > 365
 ORDER BY inactivity_days DESC;
 