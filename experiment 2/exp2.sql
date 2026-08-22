Create database ecommercedb;
use ecommercedb;


-- CUSTOMER
CREATE TABLE customer (
    customerid    INT PRIMARY KEY,
    customername  VARCHAR(100) NOT NULL,
    email         VARCHAR(100)
);

CREATE TABLE customer_phone (
    customerid INT,
    phone      VARCHAR(20),
    PRIMARY KEY (customerid, phone),
    FOREIGN KEY (customerid) REFERENCES customer(customerid)
        ON DELETE CASCADE
);

-- ADDRESS
CREATE TABLE address (
    customerid INT,
    addressid  INT,              
    street     VARCHAR(100),
    city       VARCHAR(50),
    state      VARCHAR(50),
    pincode    VARCHAR(10),
    PRIMARY KEY (customerid, addressid),
    FOREIGN KEY (customerid) REFERENCES customer(customerid)
        ON DELETE CASCADE
);

-- SELLER
CREATE TABLE seller (
    sellerid   INT PRIMARY KEY,
    sellername VARCHAR(100) NOT NULL
);

CREATE TABLE seller_phone (
    sellerid INT,
    phone    VARCHAR(20),
    PRIMARY KEY (sellerid, phone),
    FOREIGN KEY (sellerid) REFERENCES seller(sellerid)
        ON DELETE CASCADE
);

-- CATEGORY
CREATE TABLE category (
    categoryid   INT PRIMARY KEY,
    categoryname VARCHAR(100) NOT NULL
);

-- PRODUCT 
CREATE TABLE product (
    productid   INT PRIMARY KEY,
    productname VARCHAR(100) NOT NULL,
    price       DECIMAL(10,2),
    brand       VARCHAR(100),
    sellerid    INT NOT NULL,
    categoryid  INT NOT NULL,
    FOREIGN KEY (sellerid) REFERENCES seller(sellerid),
    FOREIGN KEY (categoryid) REFERENCES category(categoryid)
);

-- PAYMENT
CREATE TABLE payment (
    paymentid   INT PRIMARY KEY,
    paymentmode VARCHAR(50),
    amount      DECIMAL(10,2),
    paymentdate DATE
);

-- DELIVERY
CREATE TABLE delivery (
    deliveryid   INT PRIMARY KEY,
    status       VARCHAR(50),
    deliverydate DATE
);

-- ORDERS 
CREATE TABLE orders (
    orderid     INT PRIMARY KEY,
    orderdate   DATE,
    totalamount DECIMAL(10,2),
    customerid  INT NOT NULL,
    paymentid   INT UNIQUE,
    deliveryid  INT UNIQUE,
    FOREIGN KEY (customerid) REFERENCES customer(customerid),
    FOREIGN KEY (paymentid)  REFERENCES payment(paymentid),
    FOREIGN KEY (deliveryid) REFERENCES delivery(deliveryid)
);

-- ORDER_ITEM 
CREATE TABLE order_item (
    orderid    INT,
    itemno     INT,             -- partial key
    quantity   INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    productid  INT NOT NULL,
    PRIMARY KEY (orderid, itemno),
    FOREIGN KEY (orderid) REFERENCES orders(orderid)
        ON DELETE CASCADE,
    FOREIGN KEY (productid) REFERENCES product(productid)
);


-- CUSTOMER
INSERT INTO customer (customerid, customername, email) VALUES
(1, 'Ravi Kumar', 'ravi.kumar@email.com'),
(2, 'Anita Sharma', 'anita.sharma@email.com'),
(3, 'Mohit Verma', 'mohit.verma@email.com');

INSERT INTO customer_phone (customerid, phone) VALUES
(1, '9876543210'),
(1, '9123456780'),
(2, '9988776655'),
(3, '9012345678');

-- ADDRESS
INSERT INTO address (customerid, addressid, street, city, state, pincode) VALUES
(1, 1, '12 MG Road', 'Lucknow', 'Uttar Pradesh', '226001'),
(2, 1, '45 Park Street', 'Kolkata', 'West Bengal', '700016'),
(3, 1, '78 Brigade Road', 'Bangalore', 'Karnataka', '560025');

-- SELLER
INSERT INTO seller (sellerid, sellername) VALUES
(1, 'TechWorld Store'),
(2, 'Fashion Hub'),
(3, 'HomeEssentials');

INSERT INTO seller_phone (sellerid, phone) VALUES
(1, '9000011111'),
(2, '9000022222'),
(3, '9000033333');

-- CATEGORY
INSERT INTO category (categoryid, categoryname) VALUES
(1, 'Electronics'),
(2, 'Clothing'),
(3, 'Home & Kitchen');

-- PRODUCT
INSERT INTO product (productid, productname, price, brand, sellerid, categoryid) VALUES
(1, 'Wireless Mouse', 599.00, 'Logitech', 1, 1),
(2, 'Bluetooth Headphones', 1999.00, 'Boat', 1, 1),
(3, 'Men''s Cotton T-Shirt', 499.00, 'Levis', 2, 2),
(4, 'Non-Stick Pan', 899.00, 'Prestige', 3, 3);

-- PAYMENT
INSERT INTO payment (paymentid, paymentmode, amount, paymentdate) VALUES
(1, 'Credit Card', 2598.00, '2026-08-10'),
(2, 'UPI', 499.00, '2026-08-15'),
(3, 'Cash on Delivery', 899.00, '2026-08-18');

-- DELIVERY
INSERT INTO delivery (deliveryid, status, deliverydate) VALUES
(1, 'Delivered', '2026-08-14'),
(2, 'In Transit', '2026-08-20'),
(3, 'Pending', NULL);

-- ORDERS
INSERT INTO orders (orderid, orderdate, totalamount, customerid, paymentid, deliveryid) VALUES
(1, '2026-08-10', 2598.00, 1, 1, 1),
(2, '2026-08-15', 499.00, 2, 2, 2),
(3, '2026-08-18', 899.00, 3, 3, 3);

-- ORDER_ITEM
INSERT INTO order_item (orderid, itemno, quantity, unit_price, productid) VALUES
(1, 1, 1, 599.00, 1),
(1, 2, 1, 1999.00, 2),
(2, 1, 1, 499.00, 3),
(3, 1, 1, 899.00, 4);

desc customer;
desc customer_phone;
desc address;
desc seller;
desc seller_phone;
desc category;
desc orders;
desc payment;
desc product;
desc order_item;
desc delivery;

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
