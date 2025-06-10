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
use employees;

select first_name, hire_date
from employees
where hire_date in ("1985-08-31","1985-09-01");

# -------------------------------------------------------------+
# ----- Question 2 -----
-- Find all employee numbers whose salaries are greater than
-- the employee number = 10001
-- Write the query as a nested non-correlated subquery.

-- Answer:
select distinct emp_no, salary
from salaries
where salary > all (select salary from salaries where emp_no='10001'); 

# -------------------------------------------------------------+
# ----- Question 3 -----
-- Find the details of employees from dept_emp table ,
-- where the employee has worked in more than 1 department
-- Write the query as a nested correlated subquery.

-- Answer:
select *
from dept_emp as e1
where (select count(*) from dept_emp as e2 
where e1.emp_no=e2.emp_no 
group by e2.emp_no) >1;

# -----------------------------------------------------------+
# ----- Question 4 -----
-- Find the number of employees in each department.
-- Use nested queries approach to write the query.
-- Use the dept_emp table to find the count of employees.
-- Use the departments table to find the name of the department.

-- Answer:
select d.dept_no, d.dept_name, e.number_of_employees
from departments as d
inner join
(select dept_no, count(*) as number_of_employees from dept_emp
group by dept_no) as e
on d.dept_no=e.dept_no;



#### Exercise 2 ####
# =================================================-

# ----- Question 1 -----
-- Create a view called `title_info` with the following columns:
-- titles of employees that are working
-- number of employees under those titles (use the employee table)
-- mean salary of employee under each title
-- Display the view.

-- Answer:
use employees;
--
create view title_info (employee_title, number_of_employees, mean_salary) as
select t.title, count(e.emp_no), avg(s.salary)
from titles as t, employees as e, salaries as s
where t.emp_no=e.emp_no and s.emp_no=e.emp_no
group by title;
select * from title_info;

drop view title_info;

# -----------------------------------------------------------+
# ----- Question 2 -----
-- Update the following information in the view:
-- Update the title "Engineer" as "Junior Engineer".
-- Were you able to make the update?
-- Why and why not?

-- Answer:
update title_info
set employee_title = 'Junior Engineer'
where employee_title = 'Engineer';


# -----------------------------------------------------------+
# ----- Question 3 -----
-- Drop the view.

-- Answer:

drop view title_info;


# -----------------------------------------------------------+
# ----- Question 4 -----
-- Create dept_name as the index to the departments table.
-- Show the index.
-- Now delete the index.

-- Answer:
alter table departments
add index dept_name(dept_no);

show index from departments;

alter table departments
drop index dept_name;

show index from departments;

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
set autocommit = 0;
start transaction;
savepoint my_savepoint;
insert into departments values ("d010", "IT");
savepoint after_first_add_savepoint;
insert into departments values ("d011", "Accounting");
savepoint after_second_add_savepoint;
rollback to savepoint after_first_add_savepoint;
commit;

select * from departments;

#### Exercise 3 ####
# =================================================-

# ----- Question 1 -----
-- View all databases.
-- View all tables of the employees database.
-- View all columns of all the tables of the employees database.

-- Answer:
use employees;
show databases;
show tables from employees;
show tables from information_schema;

select *
from information_schema.columns
where table_name = 'columns';


# -----------------------------------------------------------+
# ----- Question 2 -----
-- Create a stored procedure to view emp_no, first_name, last_name, gender, hire_date of employee where of dept_no = d001.
-- Name it as "Show_employee_details"
-- Call the stored procedure. 

-- Answer:
select e.emp_no, e.first_name, e.last_name, e.gender, e.hire_date
from employees as e, dept_emp as d
where dept_no='d001' and e.emp_no=d.emp_no;

call show_employee_details;
