DROP DATABASE IF EXISTS ecommerce;
CREATE DATABASE ecommerce;
USE ecommerce;


-- 1. CUSTOMER

CREATE TABLE customer (
    customerid    INT PRIMARY KEY AUTO_INCREMENT,
    customername  VARCHAR(100) NOT NULL,
    email         VARCHAR(100) NOT NULL UNIQUE
			);

-- Multivalued  customer phone
CREATE TABLE customer_phone (
    customerid INT NOT NULL,
    phone      VARCHAR(20) NOT NULL,
    PRIMARY KEY (customerid, phone),
    FOREIGN KEY (customerid) REFERENCES customer(customerid)
        ON DELETE CASCADE
);


-- 2. ADDRESS 

CREATE TABLE address (
    customerid INT NOT NULL,
    addressid  INT NOT NULL,        
    street     VARCHAR(100) NOT NULL,
    city       VARCHAR(50)  NOT NULL,
    state      VARCHAR(50)  NOT NULL,
    pincode    VARCHAR(10)  NOT NULL,
    PRIMARY KEY (customerid, addressid),
    FOREIGN KEY (customerid) REFERENCES customer(customerid)
        ON DELETE CASCADE
);


-- 3. SELLER

CREATE TABLE seller (
    sellerid   INT PRIMARY KEY AUTO_INCREMENT,
    sellername VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE seller_phone (
    sellerid INT NOT NULL,
    phone    VARCHAR(20) NOT NULL,
    PRIMARY KEY (sellerid, phone),
    FOREIGN KEY (sellerid) REFERENCES seller(sellerid)
        ON DELETE CASCADE
);


-- 4. CATEGORY

CREATE TABLE category (
    categoryid   INT PRIMARY KEY AUTO_INCREMENT,
    categoryname VARCHAR(100) NOT NULL UNIQUE
);


-- 5. PRODUCT

CREATE TABLE product (
    productid   INT PRIMARY KEY AUTO_INCREMENT,
    productname VARCHAR(100) NOT NULL,
    price       DECIMAL(10,2) NOT NULL,
    brand       VARCHAR(100),
    sellerid    INT NOT NULL,
    categoryid  INT NULL,     
    FOREIGN KEY (sellerid) REFERENCES seller(sellerid)
        ON DELETE CASCADE,
    FOREIGN KEY (categoryid) REFERENCES category(categoryid)
        ON DELETE SET NULL
);


-- 6. PAYMENT

CREATE TABLE payment (
    paymentid   INT PRIMARY KEY AUTO_INCREMENT,
    paymentmode VARCHAR(50) NOT NULL,
    amount      DECIMAL(10,2) NOT NULL,
    paymentdate DATE NOT NULL
);


-- 7. DELIVERY

CREATE TABLE delivery (
    deliveryid   INT PRIMARY KEY AUTO_INCREMENT,
    status       VARCHAR(50) NOT NULL,
    deliverydate DATE
);


-- 8. ORDERS

CREATE TABLE orders (
    orderid     INT PRIMARY KEY AUTO_INCREMENT,
    orderdate   DATE NOT NULL,
    totalamount DECIMAL(10,2) NOT NULL,
    customerid  INT NOT NULL,
    paymentid   INT NULL UNIQUE,
    deliveryid  INT NULL UNIQUE,
    FOREIGN KEY (customerid) REFERENCES customer(customerid)
        ON DELETE CASCADE,
    FOREIGN KEY (paymentid) REFERENCES payment(paymentid)
        ON DELETE SET NULL,
    FOREIGN KEY (deliveryid) REFERENCES delivery(deliveryid)
        ON DELETE SET NULL
);


-- 9. ORDER_ITEM 
CREATE TABLE order_item (
    orderid    INT NOT NULL,
    itemno     INT NOT NULL,     
    quantity   INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    productid  INT NOT NULL,
    PRIMARY KEY (orderid, itemno),
    FOREIGN KEY (orderid) REFERENCES orders(orderid)
        ON DELETE CASCADE,
    FOREIGN KEY (productid) REFERENCES product(productid)
        ON DELETE RESTRICT
);



-- SAMPLE DATA


INSERT INTO customer (customerid, customername, email) VALUES
(1, 'Ravi Kumar',   'ravi.kumar@email.com'),
(2, 'Anita Sharma', 'anita.sharma@email.com'),
(3, 'Mohit Verma',  'mohit.verma@email.com');

INSERT INTO customer_phone (customerid, phone) VALUES
(1, '9876543210'), (1, '9123456780'),
(2, '9988776655'),
(3, '9012345678');

INSERT INTO address (customerid, addressid, street, city, state, pincode) VALUES
(1, 1, '12 MG Road',     'Lucknow',   'Uttar Pradesh', '226001'),
(2, 1, '45 Park Street', 'Kolkata',   'West Bengal',   '700016'),
(3, 1, '78 Brigade Road','Bangalore', 'Karnataka',     '560025');

INSERT INTO seller (sellerid, sellername) VALUES
(1, 'TechWorld Store'),
(2, 'Fashion Hub'),
(3, 'HomeEssentials');

INSERT INTO seller_phone (sellerid, phone) VALUES
(1, '9000011111'), (2, '9000022222'), (3, '9000033333');

INSERT INTO category (categoryid, categoryname) VALUES
(1, 'Electronics'),
(2, 'Clothing'),
(3, 'Home & Kitchen');

INSERT INTO product (productid, productname, price, brand, sellerid, categoryid) VALUES
(1, 'Wireless Mouse',        599.00,  'Logitech', 1, 1),
(2, 'Bluetooth Headphones', 1999.00,  'Boat',     1, 1),
(3, 'Men''s Cotton T-Shirt', 499.00,  'Levis',    2, 2),
(4, 'Non-Stick Pan',         899.00,  'Prestige', 3, 3);

INSERT INTO payment (paymentid, paymentmode, amount, paymentdate) VALUES
(1, 'Credit Card',      2598.00, '2026-08-10'),
(2, 'UPI',               499.00, '2026-08-15'),
(3, 'Cash on Delivery',  899.00, '2026-08-18');

INSERT INTO delivery (deliveryid, status, deliverydate) VALUES
(1, 'Delivered',  '2026-08-14'),
(2, 'In Transit', '2026-08-20'),
(3, 'Pending',     NULL);

INSERT INTO orders (orderid, orderdate, totalamount, customerid, paymentid, deliveryid) VALUES
(1, '2026-08-10', 2598.00, 1, 1, 1),
(2, '2026-08-15',  499.00, 2, 2, 2),
(3, '2026-08-18',  899.00, 3, 3, 3);

INSERT INTO order_item (orderid, itemno, quantity, unit_price, productid) VALUES
(1, 1, 1,  599.00, 1),
(1, 2, 1, 1999.00, 2),
(2, 1, 1,  499.00, 3),
(3, 1, 1,  899.00, 4);




-- (A)
INSERT INTO order_item (orderid, itemno, quantity, unit_price, productid)
VALUES (1, 3, 1, 250.00, 999);

/*
Error Code: 1452. Cannot add or update a child row: a
foreign key constraint fails (`ecommerce`.`order_item`, CONSTRAINT `order_item_ibfk_2` 
FOREIGN KEY (`productid`) REFERENCES `product` (`productid`) ON DELETE RESTRICT)
*/


-- (B)
INSERT INTO orders (orderid, orderdate, totalamount, customerid, paymentid, deliveryid)
VALUES (4, '2026-08-21', 1000.00, 999, NULL, NULL);

/*
Error Code: 1452. Cannot add or update a child row: a 
foreign key constraint fails (`ecommerce`.`orders`, CONSTRAINT `orders_ibfk_1` 
FOREIGN KEY (`customerid`) REFERENCES `customer` (`customerid`) ON DELETE CASCADE)
*/



-- (C) 
DELETE FROM product WHERE productid = 1;

/*
Error Code: 1451. Cannot delete or update a parent row: a 
foreign key constraint fails (`ecommerce`.`order_item`, CONSTRAINT `order_item_ibfk_2` 
FOREIGN KEY (`productid`) REFERENCES `product` (`productid`) ON DELETE RESTRICT)


*/

-- (D)
SELECT * FROM customer_phone WHERE customerid = 3; 
SELECT * FROM address        WHERE customerid = 3;  
SELECT * FROM orders         WHERE customerid = 3;  
SELECT * FROM order_item     WHERE orderid = 3;      

DELETE FROM customer WHERE customerid = 3;

SELECT * FROM customer_phone WHERE customerid = 3;   
SELECT * FROM address        WHERE customerid = 3;   
SELECT * FROM orders         WHERE customerid = 3;  
SELECT * FROM order_item     WHERE orderid = 3;       

/*
Error Code: 1451. Cannot delete or update a parent row: a foreign key 
constraint fails (`ecommerce`.`order_item`, CONSTRAINT `order_item_ibfk_2` FOREIGN KEY 
(`productid`) REFERENCES `product` (`productid`) ON DELETE RESTRICT)

*/

-- (E) 
SELECT productid, productname, categoryid FROM product WHERE categoryid = 3;


DELETE FROM category WHERE categoryid = 3;

SELECT productid, productname, categoryid FROM product WHERE productid = 4;


-- (F)
SELECT orderid, paymentid FROM orders WHERE orderid = 2; 

DELETE FROM payment WHERE paymentid = 2;

SELECT orderid, paymentid FROM orders WHERE orderid = 2;  

select * from customer;
select * from customer_phone;
select * from address;
select * from seller;
select * from seller_phone;
select * from category;
select * from orders;
select * from payment;
select * from product;
select * from order_item;
select * from delivery;