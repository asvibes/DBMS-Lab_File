# Experiment 2: Relational Schema, Constraints, and Referential Integrity

## Aim

To convert the ER diagram of an Indian e-commerce platform into a relational schema and implement it using MySQL with appropriate keys, constraints, and referential integrity rules.

## Objectives

* Convert the ER diagram from Experiment 1 into relational tables.
* Define primary keys and foreign keys.
* Apply `NOT NULL` and `UNIQUE` constraints.
* Implement `ON DELETE CASCADE` and `ON DELETE SET NULL`.
* Insert sample records into the tables.
* Demonstrate referential integrity violations and verify the expected errors.

## Relational Schema

The following tables represent the relational schema derived from the ER diagram designed in Experiment 1.

| Table           | Description                                   |
| --------------- | --------------------------------------------- |
| Customer        | Stores customer details.                      |
| Address         | Stores customer address information.          |
| CustomerPhone   | Stores multiple phone numbers for customers.  |
| Seller          | Stores seller information.                    |
| Category        | Stores product categories.                    |
| Product         | Stores product details.                       |
| PhysicalProduct | Stores details specific to physical products. |
| DigitalProduct  | Stores details specific to digital products.  |
| Orders          | Stores customer order information.            |
| OrderItem       | Stores products included in each order.       |
| Payment         | Stores payment information.                   |
| Delivery        | Stores delivery and tracking information.     |

*Note: The actual table names and attributes should match the SQL implementation.*

## SQL Implementation

The SQL script contains the `CREATE TABLE` statements required to implement the relational schema in MySQL.

### 1. Primary Keys and Foreign Keys

* **Primary Key (PK):** Uniquely identifies each record in a table.
* **Foreign Key (FK):** Establishes a relationship between tables and maintains referential integrity.

### 2. Constraints

The implementation demonstrates the following constraints:

* `NOT NULL` — Prevents null values in specified columns.
* `UNIQUE` — Prevents duplicate values in specified columns or column combinations.
* `ON DELETE CASCADE` — Automatically deletes dependent records when the referenced record is deleted.
* `ON DELETE SET NULL` — Sets the referencing foreign-key value to `NULL` when the referenced record is deleted, provided the column permits null values.

## Sample Data

Sample records are inserted into the tables to verify that the schema and constraints work correctly.

The sample data should demonstrate:

* Valid customer, seller, product, and order records.
* Correct relationships between tables.
* Valid primary-key and foreign-key references.
* Successful execution of verification queries.

## Referential Integrity Testing

The implementation includes invalid SQL statements to demonstrate referential integrity violations.

| Test Case                                                | Expected Result                               |
| -------------------------------------------------------- | --------------------------------------------- |
| Insert a duplicate primary key                           | Statement rejected.                           |
| Insert a duplicate value into a `UNIQUE` column          | Statement rejected.                           |
| Insert a record with a nonexistent foreign-key reference | Statement rejected.                           |
| Insert `NULL` into a `NOT NULL` column                   | Statement rejected.                           |
| Delete a referenced record with `ON DELETE CASCADE`      | Dependent records are deleted automatically.  |
| Delete a referenced record with `ON DELETE SET NULL`     | Referencing foreign-key values become `NULL`. |

## Conclusion

The ER diagram from Experiment 1 is converted into a relational schema and implemented using MySQL. Primary keys, foreign keys, integrity constraints, and deletion rules are applied to maintain data consistency and demonstrate referential integrity.
