--Q32.How many rows are in the pets table?
SELECT count(*)
FROM pets
--Q33.How many female pets are in the pets table?
SELECT count(*)
FROM pets
WHERE sex="F"
--Q34.How many female cats are in the pets table?
SELECT COUNT (*)
FROM pets
WHERE sex="F" and species="cat"
--Q35.What's the mean age of pets in the pets table?
SELECT avg(age)
from pets
--Q36.What's the mean age of dogs in the pets table?
select avg(age)
from pets
where species="dog"
--Q37.What's the mean age of male dogs in the pets table?
select avg(age)
from pets
where species="dog" and sex="M"
--Q38.What's the count, mean, minimum, and maximum of pet ages in the pets table?
SELECT count(age),
avg(age),
min(age) ,
max(age) 
FROM pets
--Q39.Repeat the previous problem with the following stipulations:
--Round the average to one decimal place.
--Give each column a human-readable column name (for example, "Average Age")
SELECT count(age) as count,
round(avg(age),1) AS mean,
min(age) AS min,
max(age) AS max
FROM pets
--Q40.How many rows in employees_null have missing salaries?
SELECT COUNT(*) as missing
FROM employees_null
WHERE salary IS NULL
--Q41.How many salespeople in employees_null having nonmissing salaries?
SELECT COUNT(*) as not_missing
FROM employees_null
WHERE salary IS NOT NULL and job="Sales"
--Q42.What's the mean salary of employees who joined the company after 2010? Go back to the usual employees table for this one.
SELECT ROUND(AVG(salary), 2) AS mean_salary
FROM employees
WHERE CAST(STRFTIME('%Y', startdate) AS REAL) > 2010
--Q43.What's the mean salary of employees in Swiss Francs?
--Hint: Swiss Francs are abbreviated "CHF" and 1 USD = 0.97 CHF.
SELECT ROUND(AVG(salary) * 0.97, 2) AS mean_salary_chf
FROM employees
--Q44.Create a query that computes the mean salary in USD as well as CHF. Give the columns human-readable names (for example "Mean Salary in USD"). Also, format them with comma delimiters and currency symbols.
SELECT printf('$%,d', AVG(salary)) as "Mean Salary in USD",
printf('%,d Fr.', AVG(salary) * 0.97) as "Mean Salary in CHF"
FROM employees
--Q45 What is the average age of pets by species?
SELECT round (AVG(age),2) as avg_age
from pets
GROUP by species
--Q46.Repeat the previous problem but make sure the species label is also displayed! Assume this behavior is always being asked of you any time you use GROUP BY.
SELECT species,
round (AVG(age),2) as avg_age
from pets
GROUP by species
--Q47.What is the count, mean, minimum, and maximum age by species in pets?
SELECT count(age) as count,
round(avg(age),1) AS mean,
min(age) AS min,
max(age) AS max
FROM pets
GROUP by species
--Q48.Show the mean salaries of each job title in employees.
SELECT job,
round (AVG(salary), 2) as mean_salary
from employees
GROUP by job
--Q49.Show the mean salaries in New Zealand dollars of each job title in employees.
SELECT job,
ROUND(AVG(salary) * 1.65, 2) AS mean_salary_nzd
FROM employees
GROUP BY job
--Q50 Show the mean, min, and max salaries of each job title in employees, as well as the numbers of employees in each category.
SELECT job, 
round(avg(salary),2) as mean_sal,
min(salary) as min_sal,
max(salary) as max_sal,
count(*) as num_emp
from employees
group by job
--Q51.Show the mean salaries of each job title in employees sorted descending by salary.
SELECT job, 
round(avg(salary),2) as mean_sal
from employees
GROUP by job
ORDER by mean_sal DESC
--Q52.What are the top 5 most common first names among employees?
SELECT firstname, count(*) as fn
from employees
GROUP by firstname
ORDER by fn DESC
LIMIT 5
--Q53.Show all first names which have exactly 2 occurrences in employees.
SELECT firstname, count(*) as fn
FROM employees
GROUP by firstname
HAVING count(*)= 2
--Q54.Take a look at the transactions table to get a idea of what it contains. Note that a transaction may span multiple rows if different items are purchased as part of the same order. The employee who made the order is also given by their ID.
SELECT *
FROM transactions
--Q55.Show the top 5 largest orders (and their respective customer) in terms of the numbers of items purchased in that order.
SELECT order_id,customer,
sum(quantity) as total_od
from transactions
GROUP by order_id
ORDER by total_od DESC
LIMIT 5
--Q56.how the total cost of each transaction.
SELECT order_id, customer,
round(sum(unit_price * quantity),2) as total
from transactions
GROUP by order_id
--Q57.Show the top 5 transactions in terms of total cost.
SELECT order_id, customer,
round(sum(unit_price * quantity),2) as total
from transactions
GROUP by order_id
ORDER BY total DESC
LIMIT 5
--Q58.Show the top 5 customers in terms of total revenue (ie, which customers have we done the most business with in terms of money?)
SELECT customer,
round(sum(unit_price * quantity),2) as total_rev
from transactions
GROUP by customer
ORDER BY total_rev DESC
LIMIT 5
--Q59.Show the top 5 employees in terms of revenue generated (ie, which employees made the most in sales?)
SELECT employee_id,
round(sum(unit_price * quantity), 2) as revenue
FROM transactions
GROUP BY employee_id
ORDER BY revenue DESC
LIMIT 5
--Q60.Which customer worked with the largest number of employees?
SELECT customer, 
count(DISTINCT employee_id) as num_emp
from transactions
GROUP by customer
ORDER by num_emp DESC
LIMIT 1
--Q61.Show all customers who've done more than $80,000 worth of business with us.
SELECT customer,
round(sum(unit_price * quantity), 2) as total_revenue
FROM transactions
GROUP BY customer
HAVING sum(unit_price * quantity) > 80000
ORDER BY total_revenue DESC

