-- assignment 1, question 3 and 4

-- Product (maker,model,type) -> model numbers are unique over all manufacturers and product types, type is laptop or PC
-- PC (model,speed,ram,hd,price) -> speed is in gigahertz (GHz), ram is in megabytes(MB), hd is in gigabytes (GB)
-- Laptop (model,speed,ram,hd,screen,price) -> speed is in gigahertz (GHz), ram is in megabytes(MB), hd is in gigabytes (GB)
-- Printer (model,color,type,price) -> color is true or false, type is laser or ink-jet

CREATE DATABASE IF NOT EXISTS assignment1;

USE assignment1;

CREATE TABLE Product(
	maker VARCHAR(30),
	model VARCHAR(30),
    type VARCHAR(30)
);

INSERT INTO Product VALUES ('dell', 'xps', 'laptop'), ('system76', 'mega', 'pc'), ('acer', 'aspire', 'laptop'), ('hp', 'elitebook', 'laptop'), ('lenovo', 'yoga', 'laptop'), ('lenovo', 'thinkpad', 'laptop'), ('asrock', 'tb3', 'pc');

CREATE TABLE PC (
	model VARCHAR(30),
    speed FLOAT(2,1),
    ram INTEGER,
    hd INTEGER,
    price INTEGER
);

INSERT INTO PC VALUES ('mega', 2.1, 4, 256, 2500), ('mega', 2.6, 8, 256, 5500), ('asrock', 3.9, 8, 512, 6500), ('asrock', 2.5, 2, 128, 1500);

CREATE TABLE Laptop (
	model VARCHAR(30),
    speed INTEGER,
    ram INTEGER,
    hd INTEGER,
    screen VARCHAR(20),
    price INTEGER
);

INSERT INTO Laptop VALUES ('xps', 2.0, 8, 512, 'HD', 2000), ('aspire', 1.8, 12, 128, 'SD', 750), ('elitebook', 2.4, 16, 256, 'HD', 1000), ('yoga', 2.2, 12, 512, 'HD', 1200), ('thinkpad', 3.2, 32, 512, 2000);



