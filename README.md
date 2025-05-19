# DataAnalytics-Assessment

## Questions, Approach, Challenges
> Question 1. Write a query to find customers with at least one funded savings plan AND one funded investment plan, sorted by total deposits.
##### Per-Question Explanations:
- The approach i used was to break down the question into 5 chuncks in form of steps.
- I then created virtual tables using each of them to solve each of the steps.
- First, i created a virtual table that contain the list of transaction record that were done on savings plan and checked that it has been funded at leaset once
- I repeated the same previous step to create a list of transaction record that were done on investment plan
- Used an inner Join to get a list of user id that has a saving and investment plan, i named this list "eligible_user"
- I counted the number of savings and investment transaction for each eligible user
- Calculated the total amouth or deposit of each user
- Create a record of customers/users with both savings and investment plan
   
  Challenges: I had a challenge coming up with conplex query to get the answer. In other to solve this, i used virtual tables and test my solutions bit by bit till i got the expected ou 

> Question 2. Calculate the average number of transactions per customer per month and categorize them: "High Frequency" (≥10 transactions/month), "Medium Frequency" (3-9 transactions/month), "Low Frequency" (≤2 transactions/month)
   Per-Question Explanations: Explain your approach to each question.
   Challenges:

3. Find all active accounts (savings or investments) with no transactions in the last 1 year (365 days)
   Per-Question Explanations: Explain your approach to each question.
   Challenges:

4.  For each customer, assuming the profit_per_transaction is 0.1% of the transaction value
   Per-Question Explanations: Explain your approach to each question.
   Challenges:

