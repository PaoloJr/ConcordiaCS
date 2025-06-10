DROP SCHEMA IF EXISTS shipping;
CREATE SCHEMA shipping;

USE shipping;

SET AUTOCOMMIT = 0;

CREATE TABLE customer(
customer_id varchar(10),
customer_name varchar(20),
customer_age int(10),
customer_city varchar(20),
CONSTRAINT pk_customer PRIMARY KEY(customer_id));

CREATE TABLE orders(
orders_id int(10),
customer_id varchar(10),
item_id int(10),
quantity int(10),
price float(10),
CONSTRAINT pk_orders PRIMARY KEY(orders_id));

INSERT INTO customer(customer_id, customer_name, customer_age, customer_city) VALUES("DC101", "Jack", 36, "Washington DC"); 
INSERT INTO customer(customer_id, customer_name, customer_age, customer_city) VALUES("MD109", "Monica", 28, "Baltimore"); 
INSERT INTO customer(customer_id, customer_name, customer_age, customer_city) VALUES("LA675", "Sara", 19, "Falls Church");
INSERT INTO customer(customer_id, customer_name, customer_age, customer_city) VALUES("MD607", "Nick", 40, "Columbia");

INSERT INTO orders(orders_id, customer_id, item_id, quantity, price) VALUES(1100, "DC101", 001, 2, 2.86);
INSERT INTO orders(orders_id, customer_id, item_id, quantity, price) VALUES(1110, "DC101", 002, 1, 2.45);
INSERT INTO orders(orders_id, customer_id, item_id, quantity, price) VALUES(2330, "MD109", 005, 5, 3.56);
INSERT INTO orders(orders_id, customer_id, item_id, quantity, price) VALUES(4450, "VG565", 005, 5, 3.56);

SET AUTOCOMMIT = 1;
