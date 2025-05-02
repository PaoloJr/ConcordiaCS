-- A subquery is a query nested inside another query, often used to filter data dynamically.
-- They can be used in WHERE, FROM, or SELECT clauses to provide intermediate results for the main query.

-- Unlike aggregate functions, window functions operate over a subset of rows without collapsing them into a single result. 
-- They enable ranking, running totals, and calculations across a partitioned dataset.
-- SUM, AVG, COUNT are aggregate functions that compute a single result.
-- RANK, DENSE_RANK, LEAD are window functions 


-- INNER JOIN returns matching rows from both tables
SELECT e.name, d.department_name 
FROM employees e
INNER JOIN departments d ON e.dept_id = d.dept_id;


--  LEFT JOIN includes unmatched rows from the left table
SELECT e.name, d.department_name 
FROM employees e
LEFT JOIN departments d ON e.dept_id = d.dept_id;


-- RIGHT JOIN does the same for the right table - includes unmatched rows from right table
SELECT e.name, d.department_name 
FROM employees e
RIGHT JOIN departments d ON e.dept_id = d.dept_id;


-- FULL JOIN returns all rows from both tables
SELECT e.name, d.department_name 
FROM employees e
FULL JOIN departments d ON e.dept_id = d.dept_id;


-- GROUP BY is used to organize data into groups so that aggregate functions can be applied to each group separately
-- HAVING used to filter aggregated results after GROUP BY, since WHERE cannot be applied to aggregate functions.
SELECT department, AVG(salary) AS avg_salary 
FROM employees
GROUP BY department HAVING AVG(salary) > 60000;


-- EXISTS is used to check for the presence of related records, while NOT EXISTS 
-- ensures a condition is met only if no matching record exists.
SELECT department_name 
FROM departments d
WHERE EXISTS ( SELECT 1 FROM employees e WHERE e.department = d.department_name);


-- UNION removes duplicates, while UNION ALL retains all rows, including duplicates
SELECT name 
FROM employees
UNION SELECT department_name FROM departments;