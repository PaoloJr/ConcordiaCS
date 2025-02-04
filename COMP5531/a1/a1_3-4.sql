-- assignment 1, question 3 and 4

-- Product (maker,model,type) -> model numbers are unique over all manufacturers and product types, type is laptop or PC
-- PC (model,speed,ram,hd,price) -> speed is in gigahertz (GHz), ram is in megabytes(MB), hd is in gigabytes (GB)
-- Laptop (model,speed,ram,hd,screen,price) -> speed is in gigahertz (GHz), ram is in megabytes(MB), hd is in gigabytes (GB)
-- Printer (model,color,type,price) -> color is true or false, type is laser or ink-jet

CREATE DATABASE IF NOT EXISTS assignment1;

USE assignment1;

CREATE TABLE IF NOT EXISTS Product(
	maker VARCHAR(30) NOT NULL,
	model INTEGER UNSIGNED PRIMARY KEY,
    type ENUM('pc', 'laptop', 'printer') NOT NULL
);

INSERT INTO Product VALUES ('dell', 1, 'laptop'), ('system76', 2, 'pc'), ('acer', 3, 'laptop'), ('hp', 4, 'laptop'), ('lenovo', 5, 'laptop'), ('framework', 6, 'laptop'), ('asrock', 7, 'pc'), ('hp', 20, 'printer'), ('brother', 21, 'printer'), ('xerox', 22, 'printer'), ('epson', 23, 'printer'), ('test', 24, 'printer');

CREATE TABLE IF NOT EXISTS PC (
	model INTEGER UNSIGNED PRIMARY KEY,
    speed DECIMAL(3,2) NOT NULL,
    ram INTEGER UNSIGNED NOT NULL,
    hd INTEGER UNSIGNED NOT NULL,
    price INTEGER UNSIGNED NOT NULL
);

INSERT INTO PC VALUES (2, 2.15, 4, 256, 2500), (2, 2.15, 8, 256, 5500), (7, 3.95, 8, 512, 6500), (7, 3.95, 2, 128, 1500);

CREATE TABLE IF NOT EXISTS Laptop (
	model INTEGER UNSIGNED PRIMARY KEY,
    speed DECIMAL(3,2) NOT NULL,
    ram INTEGER UNSIGNED NOT NULL,
    hd INTEGER UNSIGNED NOT NULL,
    screen DECIMAL(3,1) NOT NULL,
    price INTEGER UNSIGNED NOT NULL
);

INSERT INTO Laptop VALUES (1, 2.05, 8, 512, 15.4, 2000), (3, 1.85, 12, 128, 13.3, 750), (4, 2.45, 16, 256, 16.1, 1000), (5, 2.25, 12, 512, 12.2, 1200), (6, 3.25, 32, 512, 17.1, 2000);

CREATE TABLE IF NOT EXISTS Printer (
    model INTEGER UNSIGNED PRIMARY KEY,
    color BOOLEAN NOT NULL,
    type ENUM('laser', 'ink-jet') NOT NULL,
    price INTEGER UNSIGNED NOT NULL
);

INSERT INTO Printer VALUES (10, 1, 'laser', 500), (11, 0, 'ink-jet', 250), (12, 0, 'ink-jet', 650), (13, 1, 'laser', 700), (14, 2, 'laser', 150);


-- alterations
ALTER TABLE Laptop 
ADD od ENUM('cd', 'dvd', 'none') DEFAULT 'none' NOT NULL;

-- to edit existing column
-- ALTER TABLE table_name
-- MODIFY COLUMN column_name new_data_type;

-- first defaults `od` to 'none'
INSERT INTO Laptop VALUES (6, 3.2, 16, 256, 15.4, 1500, 'none'), (1, 2.0, 12, 128, 15.4, 1500, 'cd'), (4, 2.4, 24, 512, 16.1, 1250, 'dvd');

ALTER TABLE Printer
DROP color;


-- SELECT queries

-- find manufacturers that build laptops with a hard disk of at least 100 GB
-- SELECT maker
-- FROM Product, Laptop
-- WHERE Product.model=Laptop.model AND Laptop.hd>=100;

SELECT DISTINCT maker
FROM Product
WHERE type = 'Laptop' AND model IN (SELECT model FROM Laptop WHERE hd >= 100);

-- Find PC models with the hard disks that are of sizes 128 GB or 256 GB
SELECT DISTINCT model
FROM PC
WHERE hd = 128 or hd = 256;

-- find PC models with the hard disks of sizes 128 GB and 256 GB.

-- find those hard disk sizes used in PCs and laptops
SELECT hd
FROM PC
UNION
SELECT hd
FROM Laptop;

-- find those hard disk sizes used in at least two different laptop models.
SELECT hd
FROM Laptop
GROUP BY hd
HAVING COUNT(DISTINCT model) >= 2;
-- HAVING COUNT(model) >= 2;
