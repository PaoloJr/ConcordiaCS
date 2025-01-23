CREATE TABLE Employees (
	EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10,2)
);

INSERT INTO Employees (EmployeeID, FirstName, LastName, Department, Salary) 
VALUES
	(1, 'Alice', 'Smith', 'HR', 60000),
    (2, 'Bob', 'Johnson', 'IT', 75000),
    (3, 'Charlie', 'Brown', 'Finance', 50000),
    (4, 'Diana', 'Evans', 'IT', 85000);


-- DROP TABLE IF EXISTS Employees;
