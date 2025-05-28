#######################################################
#######################################################
############    COPYRIGHT - DATA SOCIETY   ############
#######################################################
#######################################################

## INTRODUCTION TO SQL PART3 EXERCISE ANSWERS ##

## NOTE: To run individual pieces of code, select the line of code and
##       press ctrl + enter for PCs or command + enter for Macs


#### Exercise 1 ####
# =================================================-


# --------Question 1 --------
-- Switch to the employees database.
-- Select title, first_name, and last_name by performing an inner join on both of the tables in the employees database.
-- Identify an appropriate joining attribute.

-- Answer:
USE employees;

SELECT t.title, e.first_name, e.last_name FROM   -- select attributes names
titles AS t INNER JOIN employees AS e   -- perform inner join of titles and employees
ON t.emp_no = e.emp_no;                  -- join on emp_no

# --------------------------------------------------+
# --------Question 2 --------
-- Select dept_no from dept_emp, first_name, and last_name by performing a left join on both the tables.
-- Identify an appropriate joining attribute.
-- How many rows have null values?

-- Answer:
SELECT d.dept_no, e.first_name, e.last_name            -- select the attributes
FROM dept_emp AS d LEFT JOIN employees AS e   -- perform left join
ON d.emp_no = e.emp_no where dept_no is NULL;                      -- joining attributes
-- No NULL rows are returned

# --------------------------------------------------+
# --------Question 3 --------
-- Select dept_no from dept_emp, first_name, and last_name by performing a right join on both the tables.
-- Identify an appropriate joining attribute.
-- How many rows have null values?

-- Answer:
SELECT d.dept_no, e.first_name, e.last_name            -- select the attributes
FROM dept_emp AS d RIGHT JOIN employees AS e   -- perform right join
ON d.emp_no = e.emp_no;                      -- joining attributes
-- dept_no is NULL for 951 rows are returned

# --------------------------------------------------+
# --------Question 4 --------
-- Join three tables - departments, employees, and and dept_emp and display the employee name and dept_name
-- Join on the dept_no and emp_no. 

-- Answer:
SELECT d.dept_name, e.first_name    -- select attributes
FROM departments AS d, employees AS e, dept_emp AS de      -- joining tables
WHERE d.dept_no = de.dept_no AND e.emp_no = de.emp_no; -- joining on dept_no and emp_no

# --------------------------------------------------+
# --------Question 5 --------
-- Find all the pairs of employees working in the same department, along with their department name.
-- Display as employee_1, employee_2, and dept_name.
-- Make sure that the same employee's name does not get displayed in both the employee_1 and employee_2 columns.

-- Answer:
SELECT e1.emp_no AS employee_1, e2.emp_no AS employee_2,  -- select attributes from employee table
d.dept_no                                                -- select dept_name from department table
FROM dept_emp AS e1, dept_emp AS e2, departments AS d                    -- table alias
WHERE e1.dept_no = e2.dept_no AND e1.dept_no = d.dept_no                -- self join and inner join
AND e1.emp_no != e2.emp_no;                                   -- non-equi join

# --------Question 6 --------
-- Select dept_id from the dept_emp table and departments table using UNION.
-- What is the number of rows returned?

-- Answer:
SELECT dept_no FROM dept_emp       -- select dept_id from employee
UNION                              -- perform union
SELECT dept_no FROM departments;    -- select dept_id from department
-- 9 rows


#### Exercise 2 ####
# =================================================-



# --------Question 1 --------
-- Switch back to the employees schema
-- Find all employees whose first_name ends with 'a'.
-- Find all departments that have 'A' anywhere in the department name.

-- Answer:
USE employees;

SELECT * FROM employees WHERE first_name LIKE '%a';
SELECT * FROM departments WHERE dept_name LIKE '%A%';

# ---------------------------------------------------------+
# ---- Question 2 ----

-- Find the number of characters in the employees' first names. Name the column length_first_name

-- Answer:
SELECT first_name, LENGTH(first_name) as length_first_name FROM employees;

# ---------------------------------------------------------+
# ---- Question 3 ----
-- Find the modulus of 10 of the salary of an employee.

-- Answer:
SELECT MOD(salary, 10), salary FROM salaries;

# ---------------------------------------------------------+
# ---- Question 4 ----
-- What will be the time exactly 76 hours, 39 minutes, and 10 seconds from now?

-- Answer:
SELECT CURRENT_TIMESTAMP() AS time_now, ADDTIME(CURRENT_TIMESTAMP(), "76:39:10") AS new_time;


# ---------------------------------------------------------+
# ---- Question 5 ----
-- What is the number of days between 9th September 2017 and 24th April 2019?

-- Answer:
SELECT DATEDIFF("2019-04-24", "2017-09-09");
-- 592


# ---------------------------------------------------------+
# ---- Question 6 ----
-- What is the salary of the highest paid employee in our employee database?

-- Answer:
SELECT MAX(salary) FROM salaries;
-- 136004

# ---------------------------------------------------------+
# ---- Question 7 ----
-- Count the number of employees in each department.
-- Count using the dept_emp table.
-- Now slightly modify the query and find the subset of result,
-- where the department has more than 1000 employees.

-- Answer:
SELECT COUNT(*), dept_no FROM dept_emp GROUP BY dept_no;

SELECT COUNT(*), dept_no FROM dept_emp GROUP BY dept_no HAVING COUNT(*) > 1000;
 
 
# ---------------------------------------------------------+
# ---- Question 8 ----
-- What is the max salary of each employee in each department?
-- Arrange in ascending order.

-- Answer:
SELECT MAX(salary), emp_no FROM salaries
 GROUP BY emp_no ORDER By MAX(salary);


# ---------------------------------------------------------+
# ---- Question 9 ----
-- What is the total salary cost incurred in each department? Name the column as 'salary_department'
-- Display total salary, dept_no, and dept_name. Order by salary_department in ascending order
-- Which department has the lowest total salary?

-- Answer:
SELECT SUM(s.salary) as salary_department, de.dept_no, d.dept_name 
FROM dept_emp AS de, departments AS d, salaries AS s
WHERE s.emp_no = de.emp_no  and d.dept_no = de.dept_no GROUP BY de.dept_no
ORDER BY salary_department;
-- Human Resources



