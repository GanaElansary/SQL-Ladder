-- Q1. Query all the data in the pets table.
SELECT * FROM pets
-- Q2. Query only the first 5 rows of the pets table.
SELECT * FROM pets LIMIT 5
--Q3.Query only the names and ages of the pets in the pets table.
SELECT name,age
FROM pets
--Q4.Query the pets in the pets table, sorted youngest to oldest.
SELECT *
from pets
--ORDER BY AGE 
--Q5.Query the pets in the pets table alphabetically.
SELECT *
FROM pets
ORDER BY name 
--Q6.Query all the male pets in the pets table.
SELECT *
from pets 
where sex="M"
--Q7.Query all the cats in the pets table.
select *
from pets 
where species="cat"
--Q8.Query all the pets in the pets table that are at least 5 years old.
SELECT *
FROM pets
where age=5
--Q9.Query all the male dogs in the pets table. Do not include the sex or species column, since you already know them.
SELECT name, age 
from pets
where sex="M" and species="dog"
--Q10.Get all the names of the dogs in the pets table that are younger than 5 years old.
select name 
from pets
where age < 5 and species = "dog"
--Q11.Query all the pets in the pets table that are either male dogs or female cats.
SELECT * FROM pets
WHERE (sex = "M" AND species = "dog")
OR (sex = "F" AND species = "cat")
--Q12.Query the five oldest pets in the pets table.
SELECT*
from pets 
order by age DESC
LIMIT 5
--Q13.Get the names and ages of all the female cats in the pets table sorted by age, descending.
SELECT name, age 
from pets 
where sex="F" and species="cat"
ORDER by age DESC
--Q14.Get all pets from pets whose names start with P.
SELECT * 
from pets 
where name like "P%"
--Q15.Select all employees from employees_null where the salary is missing.
select *
from employees_null
where salary is null 
--Q16.Select all employees from employees_null where the salary is below $35,000 or missing.
select *
from employees_null
where salary < 35000 or salary is NULL
--Q17.Select all employees from employees_null where the job title is missing. What do you see?
SELECT *
from employees_null 
where job is null 
--Q18.Who is the newest employee in employees? The most senior?
select *
from employees
order by startdate DESC 
LIMIT 1

select *
from employees
order by startdate  
LIMIT 1
--Q19.Select all employees from employees named Thomas.
SELECT *
from employees
where firstname= "Thomas"
--Q20.Select all employees from employees named Thomas or Shannon.
SELECT *
from employees
where firstname IN ("Thomas", "Shannon")
--Q21Select all employees from employees named Robert, Lisa, or any name that begins with a J. In addition, only show employees who are not in sales. This will be a little bit of a longer query.
SELECT *
FROM employees
WHERE (firstname IN ("Robert", "Lisa") OR firstname LIKE "J%")
AND job != "Sales"

--Q22.Query the top 5 rows of the employees table to get a glimpse of these new data.
select *
from employees
LIMIT 5
--Q23Query the employees table, but convert their salaries to Euros.
SELECT *, ROUND(salary / 1.1, 2) as salary_ii
FROM employees;
--Q24.Repeat the previous problem, but rename the column salary_eu.
SELECT *, ROUND(salary / 1.1, 2) as salary_eu
FROM employees;
--Q25.Query the employees table, but combine the firstname and lastname columns to be "Firstname, Lastname" format. Call this column fullname. For example, the first row should contain Thompson, Christine as fullname. Also, display the rounded salary_eu instead of salary.
SELECT firstname || "," || lastname AS fullname,
ROUND(salary / 1.1, 2) AS salary_eu
FROM employees;
--Q26.Query the employees table, but replace startdate with startyear using the SUBSTR() function. Also include fullname and salary_eu.
SELECT SUBSTR(startdate, 1, 4) AS startyear,
firstname || "," || lastname AS fullname,
ROUND(salary / 1.1, 2) AS salary_eu
FROM employees;
--Q27.Repeat the above problem, but instead of using SUBSTR(), use STRFTIME().
SELECT STRFTIME('%Y', startdate) AS startyear,
firstname || "," || lastname AS fullname,
ROUND(salary / 1.1, 2) AS salary_eu
FROM employees;
--Q28.Query the employees table, replacing firstname/lastname with fullname and startdate with startyear. Print out the salary in USD again, except format it with a dollar sign, comma separators, and no decimal. For example, the first row should read $123,696. This column should still be named salary
SELECT STRFTIME('%Y', startdate) AS startyear,
firstname || "," || lastname AS fullname,
printf('$%,.2d', salary) AS salary
FROM employees
--Q29Last year, only salespeople were eligible for bonuses. Create a column bonus that is "Yes" if you're eligible for a bonus, otherwise "No"
SELECT *,
CASE 
WHEN job = "Sales" 
THEN "Yes" 
ELSE "No"
END AS bonus
from employees
--Q30.This year, only sales people with a salary of $100,000 or higher are eligible for bonuses. Create a bonus column like in the last problem for salespeople with salaries at least $100,000.
SELECT *,
CASE
WHEN job = "Sales" AND salary >= 100000 THEN "Yes"
ELSE "No"
END AS bonus
FROM employees;
--Q31.Next year, the bonus structure will be a little more complicated. You'll create a target_comp column which represents an employee's target total compensation after their bonus.
SELECT ID, firstname, lastname, job,
printf('$%,.2d', salary) AS salary,
printf('$%,.2d',
ROUND(CASE WHEN job = "Sales" AND salary > 100000 THEN salary * 1.10
WHEN job = "Sales" AND salary < 100000 THEN salary * 1.05
WHEN job = "Administrator" THEN salary * 1.05
ELSE salary
END)) AS target_comp
FROM employees;


