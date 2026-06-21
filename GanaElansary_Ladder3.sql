--Q63.Which employee made which sale? Join the employees table onto the transactions table by employee_id. You only need to include the employee's first/last name from employees.
SELECT t.*,
e.firstname, e.lastname
FROM transactions t
JOIN employees e ON e.ID = t.employee_id
--Q64.Solve the previous problem by joining employees onto the trans_by_employee view.
SELECT e.firstname, e.lastname, v.total_cost
FROM trans_by_employee v
JOIN employees e ON e.ID = v.employee_id
ORDER BY v.total_cost DESC
LIMIT 1
--Q65 Next, the company will try to give bonuses based on performance. Show all employees who've made more in sales than 1.5 times their salary.
SELECT e.firstname, e.lastname, e.salary, v.total_cost AS total_sales
FROM trans_by_employee v
JOIN employees e ON e.ID = v.employee_id
WHERE v.total_cost > 1.5 * e.salary
ORDER BY v.total_cost DESC
--Q66.Do we have potentially erroneous rows? Find all transactions which occurred before the employee was even hired! (Make sure each transaction only occupies one row).
SELECT DISTINCT t.order_id, t.customer, t.orderdate, e.firstname, e.lastname, e.startdate
FROM transactions t
JOIN employees e ON e.ID = t.employee_id
WHERE t.orderdate < e.startdate
ORDER BY t.order_id
--Q67.Among all transactions that occurred from 2015 to 2019, create a table that is the monthly revenue of our company versus the total trading volume of Yum! in that month. Format the columns nicely. (Hint: look at the views) That is, a sample row of your result might look like this
SELECT tm.year,
tm.month,
printf('$%,d', tm.total_cost) AS company_revenue,
printf('%,d', ym.tot_volume)  AS yum_trade_volume
FROM trans_by_month tm
JOIN yum_by_month ym
ON tm.year = ym.year AND tm.month = ym.month
ORDER BY tm.year, tm.month