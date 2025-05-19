# DataAnalytics-Assessment

## Questions, Approach, Challenges
> Question 1. Write a query to find customers with at least one funded savings plan AND one funded investment plan, sorted by total deposits.
##### Per-Question Explanations:

- The approach I used was to break down the question into 5 chunks in the form of steps.
- I then created virtual tables for each step to solve the problem incrementally.
- First, I created a virtual table containing the list of transaction records related to the savings plan and verified that each had been funded at least once.
- I repeated the same process to create a virtual table with transaction records related to the investment plan.
- I used an INNER JOIN to get a list of user IDs who have both savings and investment plans, naming this list "eligible_user."
- I counted the number of savings and investment transactions for each eligible user.
- I calculated the total amount deposited by each user.
- Finally, I created a record of customers/users who have both savings and investment plans.
   
  **Challenge:** I had a challenge coming up with conplex query to get the answer. In other to solve this, i used virtual tables and test my solutions bit by bit till i got the expected ou 

> Question 2. Calculate the average number of transactions per customer per month and categorize them: "High Frequency" (≥10 transactions/month), "Medium Frequency" (3-9 transactions/month), "Low Frequency" (≤2 transactions/month)
##### Per-Question Explanations:
- The approach i used was to break down the question into 4 chuncks in form of steps.
- Using the same approach of using Virtual tables
- Firstly, i got the list of customer and the number of trasaction the have made per month every year
- Got the monthly average for each user
- Give each customer who meet the above criteria a label
- Categorized and count no. of customers in each category
  
  **Challenge:**  I had a challenge capturing all users in each category because there were some customers whose average monthly transactions were between 9 and 10, or between 2 and 3. So, I simply rounded their averages to whole numbers and then categorized them accordingly.

> Question 3. Find all active accounts (savings or investments) with no transactions in the last 1 year (365 days)
##### Per-Question Explanations:
- The approach i used was to break down the question into 4 chuncks in form of steps.
-  Using the same approach of using Virtual tables
- Firstly, i created a list of accounts and their last date of transaction
- Using that table i filtered for plan whose day diiference between last_transaction and current date is > 365
  **Challenge:** No challenge in this, the approach of braeking the solution down using virtual tables made it striate forward.

> Question 4. For each customer, assuming the profit_per_transaction is 0.1% of the transaction value
##### Per-Question Explanations:
- The approach i used was to break down the question into 4 chuncks in form of steps.
- First, i got the customers id and their tenure months
- Got the profit per transaction and total number of Transaction per user
- Made sure i account for users who does not have any transaction, using COALESCE to give them 0 value after joining with user table
  
 **Challenge:** I initially thought of using DATEDIFF to get the number of days between two dates and then dividing by 30 to estimate the number of months. However, I realized this would not be accurate because it assumes every month has exactly 30 days. After some research, I learned about TIMESTAMPDIFF, which allows specifying the unit of difference directly (such as months). Using TIMESTAMPDIFF helped me solve that challenge effectively.

