-- assignment 1, question 3 and 4

-- Product (maker,model,type) -> model numbers are unique over all manufacturers and product types, type is laptop or PC
-- PC (model,speed,ram,hd,price) -> speed is in gigahertz (GHz), ram is in megabytes(MB), hd is in gigabytes (GB)
-- Laptop (model,speed,ram,hd,screen,price) -> speed is in gigahertz (GHz), ram is in megabytes(MB), hd is in gigabytes (GB)
-- Printer (model,color,type,price) -> color is true or false, type is laser or ink-jet

CREATE DATABASE IF NOT EXISTS assignment1;

USE assignment1;

CREATE TABLE Product(
	maker VARCHAR(30),
	model INTEGER,
    type VARCHAR(30)
);

INSERT INTO Product VALUES ('dell', 1, 'laptop'), ('system76', 2, 'pc'), ('acer', 3, 'laptop'), ('hp', 4, 'laptop'), ('lenovo', 5, 'laptop'), ('framework', 6, 'laptop'), ('asrock', 7, 'pc');

CREATE TABLE PC (
	model INTEGER,
    speed FLOAT(2,1),
    ram INTEGER,
    hd INTEGER,
    price INTEGER
);

INSERT INTO PC VALUES (2, 2.1, 4, 256, 2500), (2, 2.6, 8, 256, 5500), (7, 3.9, 8, 512, 6500), (7, 2.5, 2, 128, 1500);

CREATE TABLE Laptop (
	model INTEGER,
    speed INTEGER,
    ram INTEGER,
    hd INTEGER,
    screen VARCHAR(20),
    price INTEGER
);

INSERT INTO Laptop VALUES (1, 2.0, 8, 512, 'HD', 2000), (3, 1.8, 12, 128, 'SD', 750), (4, 2.4, 16, 256, 'HD', 1000), (5, 2.2, 12, 512, 'HD', 1200), (6, 3.2, 32, 512, 2000);



