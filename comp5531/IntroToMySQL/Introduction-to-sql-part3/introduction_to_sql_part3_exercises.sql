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


# --------------------------------------------------+
# --------Question 2 --------
-- Select dept_no from dept_emp, first_name, and last_name by performing a left join on both the tables.
-- Identify an appropriate joining attribute.
-- How many rows have null values?

-- Answer:


# --------------------------------------------------+
# --------Question 3 --------
-- Select dept_no from dept_emp, first_name, and last_name by performing a right join on both the tables.
-- Identify an appropriate joining attribute.
-- How many rows have null values?

-- Answer:


# --------------------------------------------------+
# --------Question 4 --------
-- Join three tables - departments, employees, and and dept_emp and display the employee name and dept_name
-- Join on the dept_no and emp_no. 

-- Answer:


# --------------------------------------------------+
# --------Question 5 --------
-- Find all the pairs of employees working in the same department, along with their department name.
-- Display as employee_1, employee_2, and dept_name.
-- Make sure that the same employee's name does not get displayed in both the employee_1 and employee_2 columns.

-- Answer:


# --------Question 6 --------
-- Select dept_id from the dept_emp table and departments table using UNION.
-- What is the number of rows returned?

-- Answer:



#### Exercise 2 ####
# =================================================-



# --------Question 1 --------
-- Switch back to the employees schema
-- Find all employees whose first_name ends with 'a'.
-- Find all departments that have 'A' anywhere in the department name.

-- Answer:
use employees;
--
select first_name
from employees
where first_name like '%a';
--
select dept_name
from departments
where dept_name like '%A%';
# ---------------------------------------------------------+
# ---- Question 2 ----

-- Find the number of characters in the employees' first names. Name the column length_first_name

-- Answer:
select first_name, length(first_name) as length_first_name
from employees;


# ---------------------------------------------------------+
# ---- Question 3 ----
-- Find the modulus of 10 of the salary of an employee.

-- Answer:
select emp_no, salary, mod(salary,10) as modulus
from salaries;

# ---------------------------------------------------------+
# ---- Question 4 ----
-- What will be the time exactly 76 hours, 39 minutes, and 10 seconds from now?

-- Answer:
select current_timestamp() as time_now, "76:39:10" as added_time,
addtime(current_timestamp(), "76:39:10") as new_time;

# ---------------------------------------------------------+
# ---- Question 5 ----
-- What is the number of days between 9th September 2017 and 24th April 2019?

-- Answer:
select datediff("2019/04/24","2017/09/09") as date_diff;


# ---------------------------------------------------------+
# ---- Question 6 ----
-- What is the salary of the highest paid employee in our employee database?

-- Answer:
select max(s.salary) as salary, s.emp_no, e.first_name, e.last_name
from salaries as s
left join employees as e on s.emp_no=e.emp_no;

# ---------------------------------------------------------+
# ---- Question 7 ----
-- Count the number of employees in each department.
-- Count using the dept_emp table.
-- Now slightly modify the query and find the subset of result,
-- where the department has more than 1000 employees.

-- Answer:
select dept_no, count(emp_no) as num_employees
from dept_emp
group by dept_no
having count(emp_no)>1000;

# ---------------------------------------------------------+
# ---- Question 8 ----
-- What is the max salary of each employee in each department?
-- Arrange in ascending order.

-- Answer:
select salaries.emp_no, de.dept_no, max(salaries.salary) as salary
from salaries
inner join dept_emp as de on salaries.emp_no=de.emp_no
group by de.dept_no
order by salary asc;

# ---------------------------------------------------------+
# ---- Question 9 ----
-- What is the total salary cost incurred in each department? Name the column as 'salary_department'
-- Display total salary, dept_no, and dept_name. Order by salary_department in ascending order
-- Which department has the lowest total salary?

-- Answer:
select de.dept_no, d.dept_name, sum(s.salary) as salary_department
from dept_emp as de, departments as d, salaries as s
where s.emp_no=de.emp_no and de.dept_no=d.dept_no
group by dept_no
order by salary_department;


