#######################################################
#######################################################
############    COPYRIGHT - DATA SOCIETY   ############
#######################################################
#######################################################

## INTRODUCTION TO SQL PART4 EXERCISE ANSWERS ##

## NOTE: To run individual pieces of code, select the line of code and
##       press ctrl + enter for PCs or command + enter for Macs


#### Exercise 1 ####
# =================================================-

# ----- Question 1 -----
-- Use the employees schema. Find all the employee first names with hire date 1985-08-31 or 1985-09-01.
-- Write the query as a nested non-correlated subquery.

-- Answer:
USE employees;

SELECT first_name 
FROM employees 
WHERE hire_date = '1985-08-31' OR  -- outer query
first_name IN                                           -- inner query relation
(SELECT first_name FROM employees WHERE hire_date = '1985-09-01');  -- inner query


# -------------------------------------------------------------+
# ----- Question 2 -----
-- Find all employee numbers whose salaries are greater than
-- the employee number = 10001
-- Write the query as a nested non-correlated subquery.

-- Answer:
SELECT distinct emp_no FROM salaries WHERE salary > all
(SELECT salary FROM salaries WHERE emp_no = 10001);


# -------------------------------------------------------------+
# ----- Question 3 -----
-- Find the details of employees from dept_emp table ,
-- where the employee has worked in more than 1 department
-- Write the query as a nested correlated subquery.

-- Answer:
SELECT * FROM dept_emp AS e1 WHERE
(SELECT COUNT(*) FROM dept_emp AS e2 WHERE
 e1.emp_no = e2.emp_no GROUP BY e2.emp_no) > 1;

# -----------------------------------------------------------+
# ----- Question 4 -----
-- Find the number of employees in each department.
-- Use nested queries approach to write the query.
-- Use the dept_emp table to find the count of employees.
-- Use the departments table to find the name of the department.

-- Answer:
SELECT d.dept_no, d.dept_name, e.number_of_employee
FROM departments AS d
INNER JOIN
(SELECT dept_no, COUNT(*) AS number_of_employee FROM dept_emp
GROUP BY dept_no) AS e
ON d.dept_no = e.dept_no;



#### Exercise 2 ####
# =================================================-

# ----- Question 1 -----
-- Create a view called `title_info` with the following columns:
-- titles of employees that are working
-- number of employees under those titles (use the employee table)
-- mean salary of employee under each title
-- Display the view.

-- Answer:
CREATE VIEW title_info(title, count_of_employees, mean_salary) AS
SELECT t.title, count(e.emp_no), AVG(s.salary)
FROM titles AS t, employees AS e, salaries AS s
WHERE t.emp_no = e.emp_no AND e.emp_no = s.emp_no
GROUP BY t.title;

SELECT * FROM title_info;


# -----------------------------------------------------------+
# ----- Question 2 -----
-- Update the following information in the view:
-- Update the title "Engineer" as "Junior Engineer".
-- Were you able to make the update?
-- Why and why not?

-- Answer:
UPDATE title_info
SET title = "Junior Engineer"
WHERE title = "Engineer";

-- The view is not updatable, because it is obtained by the group_by clause and aggregate functions. 


# -----------------------------------------------------------+
# ----- Question 3 -----
-- Drop the view.

DROP VIEW title_info;


# -----------------------------------------------------------+
# ----- Question 4 -----
-- Create dept_name as the index to the departments table.
-- Show the index.
-- Now delete the index.

-- Answer:
ALTER TABLE departments ADD INDEX dept_name_idx(dept_name); -- add an index
SHOW INDEX FROM departments;  -- show the index
ALTER TABLE departments DROP INDEX dept_name_idx; -- drop the index

# -----------------------------------------------------------+
# ----- Question 5 -----
-- We have three users updating the database at the same time.
-- Set the autocommit = 0.
-- We want to add two new rows to the departments table.
-- Start a transaction.
-- Make sure to set savepoints whenever required.
-- Add two rows into project - (dept_no, dept_name)
	-- ("d010", "IT")
	-- ("d011", "Accounting")
-- In the middle of the transaction, we realized that the second row we are trying to add is false data.
-- Rollback to the first row insertion point.
-- Commit the transaction.
-- Check the project table to make sure only one row is added. 

-- Answer:
SET AUTOCOMMIT = 0;                                    -- set the autocommit to 0
START TRANSACTION;                                     -- begin a transaction
SAVEPOINT my_savepoint;                                -- check a savepoint
INSERT INTO departments VALUES("d010", "IT");   -- insert a row into project
SAVEPOINT after_row_one_savepoint;                     -- check a savepoint
INSERT INTO departments VALUES("d011", "Accounting");    -- insert another row
ROLLBACK TO SAVEPOINT after_row_one_savepoint;         -- rollback to the previous savepoint
COMMIT;                                                -- commit the work

SELECT * FROM departments;


#### Exercise 3 ####
# =================================================-

# ----- Question 1 -----
-- View all databases.
-- View all tables of the employees database.
-- View all columns of all the tables of the employees database.

-- Answer:
SHOW DATABASES;
SHOW TABLES FROM employees;
SHOW COLUMNS FROM departments;
SHOW COLUMNS FROM dept_emp;
SHOW COLUMNS FROM salaries;
SHOW COLUMNS FROM titles;

# -----------------------------------------------------------+
# ----- Question 2 -----
-- Create a stored procedure to view emp_no, first_name, last_name, gender, hire_date of employee where of dept_no = d001.
-- Name it as "Show_employee_details"
-- Call the stored procedure. 

-- Answer:
-- Use Workbench to create a stored procedure.
-- Insert command below into the procedure body.

SELECT e.emp_no, e.first_name, e.last_name, e.gender, e.hire_date
FROM employees as e, dept_emp as d
WHERE d.dept_no = "d001"
AND d.emp_no = e.emp_no;

CALL Show_employee_details;


