#######################################################
#######################################################
############    COPYRIGHT - DATA SOCIETY   ############
#######################################################
#######################################################

## INTRODUCTION TO SQL PART2 EXERCISE ANSWERS ##

## NOTE: To run individual pieces of code, select the line of code and
##       press ctrl + enter for PCs or command + enter for Macs


#### Exercise 1 ####
# =================================================-

# -------- Question 1 --------

-- Use "company" database.
-- Create two tables in the "company" database.
-- Name the tables "Employee" and "Department"
-- 1. "Employee" should contain 3 columns:
-- 	a. employee_id of type varchar(10)
-- 	b. employee_name of type varchar(30),
-- 	c. employee_mail of type varchar(30)
-- 2. "Department" should contain 3 columns:
--  a. dept_id int(3)
-- 	b. dept_name varchar(20) 
-- 	c. dept_phone varchar(15)


-- Use dept_id as the foreign key to the employee table. 
-- Name employee_id and dept_id as the primary keys in their respective tables.
-- NOTE: Create the parent table first and then the child table, otherwise you will get an error!
-- Inspect the table structures.

-- Answer:
-- Use "company" database
USE company;

-- Create tables

-- First parent table
CREATE TABLE Department(  -- department table name
dept_id int(3),           -- department Id
dept_name varchar(20),    -- department name
dept_phone varchar(15),   -- department phone
CONSTRAINT pk_dept PRIMARY KEY(dept_id));  -- dept_id as the primary key


-- Then child table
CREATE TABLE Employee(   -- employee table name
employee_id varchar(10), -- employee id
employee_name varchar(30),  -- employee name
employee_mail varchar(30),  -- employee mail
dept_id int(3),             -- department id
CONSTRAINT pk_emp PRIMARY KEY(employee_id), -- employee id as primary key
CONSTRAINT fk_dep FOREIGN KEY(dept_id)  -- dept_id as foreign key
REFERENCES Department(dept_id)          -- foreign key reference table
);

-- Inspect table structure
DESC Department;
DESC Employee;

# ------------------------------------------------+

# -------- Question 2 --------
-- Insert two rows into the Department table as follows: (dept_id, dept_name, dept_phone)
-- (101, "SAP", 3335641023)
-- (103, "BA", 2233456244)  
-- Display all the data in the Department table.

-- Answer:
-- Insert two rows
INSERT INTO Department(dept_id, dept_name, dept_phone)
	VALUES(101, "SAP", 3335641023);
 
INSERT INTO Department(dept_id, dept_name, dept_phone)
	VALUES(103, "BA", 2233456244);

-- Display all values in the table
SELECT * FROM Department;

# ------------------------------------------------+
# -------- Question 3 --------
-- Insert three rows in to the Employee table as follows: 
-- (employee_id, employee_name, employee_mail, dept_id)
-- ("SAP2343", "Andrew", "andrew@abc.com", 101)
-- ("BA5324", "Jennie", "jennie@abc.com", 103)
-- ("BA6765", "Rashmi", "rashmi@abc.com", 103)
-- Display all the data in the employee table.

-- Answer:

-- Insert three rows
INSERT INTO Employee(employee_id, employee_name, employee_mail, dept_id)
	VALUES("SAP2343", "Andrew", "andrew@abc.com", 101);

INSERT INTO Employee(employee_id, employee_name, employee_mail, dept_id)
	VALUES("BA5324", "Jennie", "jennie@abc.com", 103);
    
INSERT INTO Employee(employee_id, employee_name, employee_mail, dept_id)
	VALUES("BA6765", "Rashmi", "rashmi@abc.com", 103);
    
-- Display all values in the table
SELECT * FROM Employee;

# ------------------------------------------------+
# -------- Question 4 --------
-- Insert a new row into the Employee table as follows:
-- (employee_id, employee_name, employee_mail, dept_id)
-- ("SAP2453", "Andrea", "andrea@abc.com", 104)
-- Insert a new row into the department table as follows: (dept_id, dept_name, dept_phone)
-- ("abc34", "MS&S", 3335900023)
-- Are you able to successfully run the query?
-- why or why not?

-- Answer:
-- Insert a row into the Employee table
INSERT INTO Employee(employee_id, employee_name, employee_mail, dept_id)
	VALUES("SAP2453", "Andrea", "andrea@abc.com", 104);
	
	
-- Cannot insert because dept_id = 104 does not exist in the parent table.
-- This is a foreign key constraint; we can insert only if the dept_id = 104 data exist in the department table.

-- Insert into the Department table
INSERT INTO Department(dept_id, dept_name, dept_phone)
 VALUES("abc34", "MS&S", 3335900023);
-- Cannot insert because dept_id is of int data type in the schema; we are trying to insert varchar type.
-- This is CHECK constraint which checks for specific condition.

# ------------------------------------------------+
# -------- Question 5 --------

-- Check the table before updating it.
-- Update the Department table by changing the value "SAP" to "SAP ERP".
-- Check the table after updating it.

-- Answer:
SELECT * from Department; -- Check value before update

-- Update query
UPDATE Department
SET dept_name = "SAP ERP" -- Set new value
where dept_id = 101;      -- condition to update

SELECT * from Department;  -- Check value after update

# ------------------------------------------------+
# -------- Question 6 --------
-- Show the columns in the Employee table.
-- Add a new column emp_phone int(10) into the Employee table.
-- Modify the column emp_phone by changing the datatype to varchar(15) from int.
-- Show the columns in the Employee table.
-- Delete the column emp_phone from the Employee table.
-- Show the columns in the Employee table to check the final result.

-- Answer:
DESC Employee; -- check structure before adding a new column

ALTER TABLE Employee    
ADD emp_phone int(10);  -- add new column emp_phone

DESC Employee; -- check structure after adding

ALTER TABLE Employee
MODIFY emp_phone varchar(15); -- modify the column type from int to varchar

DESC Employee; -- check table structure after modify

ALTER TABLE Employee 
DROP COLUMN emp_phone;  -- delete the column emp_phone


DESC Employee; -- check table structure after delete

# ------------------------------------------------+
# -------- Question 7 --------
-- Delete BA's record from the Department table. NOTE: Remember to delete the corresponding child rows first in the Employee table.
-- Delete all the rows from the Employee table.
-- Drop all the tables from the company database.

-- Answer:
DELETE FROM Employee WHERE dept_id = 103; -- delete child first
DELETE FROM Department WHERE dept_id = 103; -- delete BA entries from department table

DELETE FROM Employee; -- delete all the data from Employee

DROP TABLE Employee; -- drop employee table
DROP TABLE Department; -- delete department table



#### Exercise 2 ####
# =================================================-

# --------Question 1 --------
-- Import data from the employees.sql script that's in the data folder.
  -- if the employees.sql is throwing a `failed to import error` while loading, open the employees.sql in a text editor
  -- on lines 102, 104, 106, 108, 110, and 112 give the full path of load_departments.dump, load_employees.dump, load_dept_emp.dump, load_titles.dump, load_salaries1.dump, show_elapsed.sql
  -- for example: /Users/user-name/desktop/skillsoft-sql-2021/data/show_elapsed.sql in macs
  -- C:/Users/user-name/desktop/skillsoft-sql-2021/data/show_elapsed.sql in windows
  -- save the changes and try importing again
-- Switch to the employees database.
-- Inspect the schema of the tables in the employee database.

-- Answer:
-- Import through MySQL workbench by using the `Data Import/Restore` option in the MANAGEMENT section on the left hand side.
USE employees;    -- use employee database 
DESC employees;      -- inspect Employee table
DESC departments;    -- inspect Department table
DESC titles;       -- inspect titles table

# --------------------------------------------------+
# --------Question 2 --------
-- Select distinct dept_name from departments table.
-- Alias the table as 'dep'.

-- Answer:
SELECT DISTINCT dep.dept_name   -- distinct dept_name
FROM departments AS dep;         -- alias departments as dep

# --------------------------------------------------+
# --------Question 3 --------
-- Select emp_no, first_name as 'Name' and all in uppercase from the Employee table.

-- Answer:
SELECT emp_no, UPPER(first_name) AS Name  -- first_name as Name in upper case
FROM employees;

# --------------------------------------------------+
# --------Question 4 --------
-- Display all the data of employees whose dept_no is d007.

-- Answer:
SELECT * FROM dept_emp WHERE dept_no = 'd007';                         -- select data where dept_no is d007

# --------------------------------------------------+
# --------Question 5 --------
-- Find the data of all the titles where the emp_no is in the set
-- 10001, 10005, 10007.

-- Answer:
SELECT * FROM titles WHERE emp_no IN (10001, 10005, 10007);      -- select data from titles table if emp_no contains 0001, 10005, 10007

# --------------------------------------------------+
# --------Question 6 --------
-- Display all the data from salaries tables where the salary of the employee is between 60000 and 70000.
-- Answer:
SELECT * FROM salaries WHERE salary BETWEEN 60000 and 70000;  -- use between to specify the range of the age

# --------------------------------------------------+
# --------Question 7 --------
-- Order the salaries table in decreasing order of salary.
-- Retrieve the emp_no of the highest paid employee.

-- Answer:
SELECT * FROM salaries ORDER BY salary DESC;        -- order in descending order
-- 10897 is the highest paid employee



