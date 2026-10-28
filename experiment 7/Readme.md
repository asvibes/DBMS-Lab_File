# Experiment: Database Normalization (UNF to 3NF)

## Aim

To normalize a denormalized sales table step-by-step from Unnormalized Form (UNF) to First Normal Form (1NF), and Third Normal Form (3NF) using MySQL. To create related tables, establish primary and foreign key relationships, and verify data reconstruction through joins.

## Objectives

* Create a denormalized sales table containing order, customer, product, and salesperson information.
* Convert the sales table from UNF to 1NF by defining a composite primary key.
* Decompose the sales data into separate tables to reduce redundancy.
* Create Customers, Salespersons, Products, Orders, and Order_Details tables.
* Establish primary key and foreign key constraints to maintain referential integrity.
* Create a 3NF order table referencing customer and salesperson records.
* Demonstrate functional dependencies using Employee-Supervisor and Supervisor-Project relationships.
* Reconstruct the original sales information using multiple joins.
* Verify the reconstructed data using a row count.
* Inspect table definitions and constraints using `SHOW CREATE TABLE`.

## Database Used

`SalesNormalization` — a database created specifically for demonstrating the normalization of sales data.

## SQL Implementation

### 1. Creating the Unnormalized Sales Table (UNF)

Creates the `Sales_UNF` table containing order details, customer information, product information, and salesperson information in a single table.

The table includes:

* Order ID and order date.
* Customer ID and customer name.
* Product ID and product name.
* Quantity and unit price.
* Salesperson ID and salesperson name.

Sample records are inserted to demonstrate repeated order, customer, product, and salesperson information. The table is displayed using `SELECT *`.

### 2. Converting the Table into First Normal Form (1NF)

Creates the `Sales_1NF` table with the same attributes as the original sales table.

A composite primary key consisting of `Order_ID` and `Product_ID` is defined to uniquely identify each product entry within an order.

The data from `Sales_UNF` is copied into `Sales_1NF`, and the resulting records are displayed.

### 3. Creating the Orders Table

Creates the `Orders` table to store order-level information separately from individual product details.

The table contains:

* Order ID.
* Order date.
* Customer ID and customer name.
* Salesperson ID and salesperson name.

The `DISTINCT` keyword is used to insert unique order records from `Sales_1NF`, reducing the repetition of order-level information.

### 4. Creating the Products Table

Creates the `Products` table to store product information separately.

The table contains:

* Product ID.
* Product name.
* Unit price.

`Product_ID` is defined as the primary key. Unique product records are copied from `Sales_1NF` using `SELECT DISTINCT`.

### 5. Creating the Order_Details Table

Creates the `Order_Details` table to represent the relationship between orders and products.

The table contains:

* Order ID.
* Product ID.
* Quantity.

A composite primary key `(Order_ID, Product_ID)` prevents the same product from appearing more than once in the same order. Foreign keys reference the `Orders` and `Products` tables to maintain referential integrity.

### 6. Creating the Customers and Salespersons Tables

Creates two separate tables to eliminate repeated customer and salesperson details.

**Customers** stores:

* Customer ID.
* Customer name.

**Salespersons** stores:

* Salesperson ID.
* Salesperson name.

The respective ID columns are defined as primary keys, and distinct records are inserted from `Sales_1NF`.

### 7. Creating the Orders_3NF Table

Creates the `Orders_3NF` table to store order-level information without repeating customer and salesperson names.

The table contains:

* Order ID.
* Order date.
* Customer ID.
* Salesperson ID.

Foreign keys reference `Customers(Customer_ID)` and `Salespersons(Salesperson_ID)`.

This design separates customer and salesperson details from order records and reduces update, insertion, and deletion anomalies caused by redundant data.

### 8. Demonstrating Employee-Supervisor and Supervisor-Project Relationships

Creates three tables:

* `Employee_Assignment` — records employees assigned to projects and their supervisors.
* `Supervisor_Project` — records the project associated with each supervisor.
* `Employee_Supervisor` — records employee-supervisor relationships.

Sample records are inserted into these tables.

A JOIN between `Employee_Supervisor` and `Supervisor_Project` retrieves each employee's ID, project ID, and supervisor ID.

This demonstrates how related information can be reconstructed from separate relations. The example also illustrates a functional dependency in which `Supervisor_ID` determines `Project_ID`.

### 9. Reconstructing Sales Information Using Joins

Uses multiple INNER JOIN operations to reconstruct the original sales information from the normalized tables.

The query joins:

* `Orders_3NF` with `Customers` using `Customer_ID`.
* `Orders_3NF` with `Salespersons` using `Salesperson_ID`.
* `Orders_3NF` with `Order_Details` using `Order_ID`.
* `Order_Details` with `Products` using `Product_ID`.

The resulting output displays order information, customer details, product details, quantities, prices, and salesperson information.

The records are sorted by `Order_ID` and `Product_ID` for easier verification.

### 10. Verifying the Reconstructed Data

Uses `COUNT(*)` on the joined normalized tables to calculate the number of reconstructed sales rows.

This verifies that the joins reconstruct the expected number of order-product records from the sample dataset.

### 11. Verifying Table Definitions and Constraints

Uses `SHOW CREATE TABLE` for the following tables:

* `Customers`
* `Salespersons`
* `Orders_3NF`
* `Products`
* `Order_Details`

These statements display the table definitions, primary keys, foreign keys, and other constraints, allowing the database structure to be verified.

## Conclusion

The experiment demonstrates the normalization of sales data by separating customer, salesperson, product, order, and order-detail information into related tables. Primary keys and foreign keys establish relationships and maintain referential integrity, while JOIN operations reconstruct the original sales information from the normalized structure. The additional employee-supervisor example illustrates how related data can be decomposed and retrieved through relational joins.
