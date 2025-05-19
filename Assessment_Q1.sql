
-- High-Value Customers with Multiple Products
-- Break down the logics into virtual tables
-- Kindly make sure the database has been selected

-- Filter only funded savings plans and name the table funded_user_plans
WITH funded_user_plans AS (
	SELECT DISTINCT plan.owner_id, plan.id AS plan_id
    FROM plans_plan AS plan
    JOIN savings_savingsaccount AS savings
    ON savings.plan_id = plan.id
    WHERE plan.is_regular_savings = 1 AND
    savings.confirmed_amount IS NOT NULL
    ),
   
-- Filter only funded investment plans and name the table funded_investment
   funded_investment AS (
	SELECT DISTINCT plan.owner_id, plan.id AS plan_id
    FROM plans_plan AS plan
    JOIN savings_savingsaccount AS savings
    ON savings.plan_id = plan.id
    WHERE plan.is_a_fund = 1 AND
    savings.confirmed_amount IS NOT NULL
    ),
    
-- Get only users who have both a funded savings and funded investment plan  and name the table eligible_user
    eligible_user AS (
    SELECT fs.owner_id
    FROM funded_user_plans AS fs
    INNER JOIN funded_investment AS fi
    ON fs.owner_id = fi.owner_id
    GROUP BY fs.owner_id
    ),
    
-- Count savings and investment plans for each eligible user  and name the table user_plan_count
    user_plan_count AS (
    SELECT 
		plan.owner_id,
        COUNT(DISTINCT CASE WHEN plan.is_regular_savings = 1 THEN plan.id END) AS savings_count,
        COUNT(DISTINCT CASE WHEN plan.is_a_fund = 1 THEN plan.id END) AS investment_count
	FROM plans_plan AS plan
    JOIN eligible_user AS eu
    ON eu.owner_id = plan.owner_id
    GROUP BY plan.owner_id
    ),
    
-- Sum confirmed deposits by user and name the table user_deposits
    user_deposits AS (
    SELECT 
        plan.owner_id,
        SUM(transactions.confirmed_amount) AS total_deposits
    FROM savings_savingsaccount AS transactions
    JOIN plans_plan AS plan 
    ON transactions.plan_id = plan.id
    JOIN eligible_user AS eu 
    ON plan.owner_id = eu.owner_id
    WHERE transactions.confirmed_amount IS NOT NULL
    GROUP BY plan.owner_id
)

-- Final result, bring and use all the virtual tables together
SELECT 
    users.id AS owner_id,
    CONCAT(users.first_name, ' ', users.last_name) AS name,
    upc.savings_count,
    upc.investment_count,
    ROUND(COALESCE(ud.total_deposits, 0), 2) AS total_deposits
FROM users_customuser AS users

-- create an inner join of user table with elegible_user virtual table
JOIN eligible_user AS eu
ON eu.owner_id = users.id

-- create an inner join of user table with count of user plan virtual table
JOIN user_plan_count AS upc 
ON users.id = upc.owner_id

-- create an left join user table with user_deposits virtual table
LEFT JOIN user_deposits AS ud ON users.id = ud.owner_id
ORDER BY total_deposits DESC;

