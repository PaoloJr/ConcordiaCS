-- distinct / unique
SELECT DISTINCT Department 
FROM Employees;

-- aliases
SELECT FirstName AS 'First Name', LastName AS 'Last Name', Salary * 12 AS 'Annual Salary' 
FROM Employees; 

SELECT * FROM Employees 
WHERE Department = 'IT';

-- AND
SELECT * FROM Employees 
WHERE Department = 'IT' AND Salary > 80000; 

-- NOT
SELECT * FROM Employees 
WHERE NOT Department = 'HR';

-- MIN
SELECT MIN(Salary) AS 'Lowest Salary' 
FROM Employees; 

-- MAX
SELECT MAX(Salary) AS 'Highest Salary' 
FROM Employees;

-- COUNT
SELECT COUNT(*) AS 'Total Employees' 
FROM Employees; 

SELECT COUNT(*) AS 'IT Employees' 
FROM Employees 
WHERE Department = 'IT';

-- JOIN
SELECT e.EmployeeID, e.FirstName, e.LastName, d.DepartmentName 
FROM Employees e 
JOIN Departments d ON e.Department = d.DepartmentName;

-- GROUP BY
SELECT Department, COUNT(*) AS 'Employee Count' 
FROM Employees 
GROUP BY Department;

-- HAVING
SELECT Department, COUNT(*) AS 'Employee Count' 
FROM Employees 
GROUP BY Department 
HAVING COUNT(*) > 1;

-- ORDER BY
SELECT FirstName, LastName, Salary 
FROM Employees 
ORDER BY Salary DESC;

